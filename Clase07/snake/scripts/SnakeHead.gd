class_name SnakeHead
extends EntityWithState

const CELL:int = 32
const GRID_W:int = 20
const GRID_H:int = 15

var direction: Vector2 = Vector2.RIGHT
var next_dir : Vector2 = Vector2.RIGHT
var move_speed : float = 0.18
var _move_timer: float = 0.0
var positions : Array[Vector2] = []
var segments: Array[Node2D] = []
var grow_count : int = 0
var segment_scene:PackedScene = null

signal grew(new_lenght:int)
signal ate_food(points:int)

func _setup() -> void:
	entity_name = "Snake"
	max_health = 1
	add_to_group("player")
	
func _ready() -> void:
	super._ready()
	positions.append(global_position)
	_change_state(SnakeMovingState.new())

func _do_move()->void:
	direction = next_dir
	var new_pos = positions[0] + direction * CELL
	if new_pos.x < 0 or new_pos.x > GRID_W * CELL or new_pos.y < 0 or new_pos.y >= GRID_H * CELL:
		is_alive = false
		return
	for p in positions:
		if new_pos == p: 
			is_alive = false
			return
	positions.push_front(new_pos)
	global_position = new_pos
	if grow_count > 0:
		grow_count -=1
		_add_segment()
	else:
		positions.pop_back()
		_move_segments()
		
func _add_segment()->void:
	if segment_scene == null:
		return
	var seg = segment_scene.instantiate()
	seg.global_position = positions[positions.size() - 1]
	get_parent().add_child(seg)
	segments.append(seg)
	grew.emit(segments.size() + 1)
	
func _move_segments()->void:
	for i in segments.size():
		segments[i].global_position = positions[i+1]

func grow(amount:int=1)->void:
	grow_count += amount

func get_length()->int: return segments.size() +1
func speed_up(factor:float)->void:
	move_speed = max(0.86,move_speed * factor)
	
