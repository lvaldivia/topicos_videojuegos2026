extends Node2D

const CELL : int = 32
const GRID_W : int = 20
const GRID_H : int = 15

@onready var snake:SnakeHead = $SnakeHead

var seg_scene: PackedScene = preload("res://snake/scenes/SnakeSegment.tscn")
var _foods: Array = []

func _ready() -> void:
	snake.segment_scene = seg_scene
	snake.state_changed.connect(_on_state_changed)
	snake.grew.connect(_on_grew_changed)
	snake.ate_food.connect(_on_ate)
	_spawn_food()

func _on_state_changed():
	pass

func _on_grew_changed():
	pass

func _process(delta: float) -> void:
	_check_food_collision()

func _spawn_food()->void:
	var pos = _random_pos()
	var food = FoodFactory.create_random(pos)
	if not food:return
	add_child(food)
	food.global_position = pos
	_foods.append(food)
	food.eaten.connect(_on_ate)

func _on_ate(food:Food):
	_foods.erase(food)
	if food.grow_amount > 0:
		snake.grow(food.grow_amount)	
	snake.ate_food.emit(food.points)
	_spawn_food()


func _check_food_collision()->void:
	for food in _foods:
		if not is_instance_valid(food):continue
		if snake.global_position.distance_to(food.global_position) < CELL * 0.8:
			(food as Food).eat()

func _random_pos() ->Vector2:
	for _i in 100:
		var x = (randi() % GRID_W) * CELL
		var y = (randi() % GRID_H) * CELL
		var pos = Vector2(x,y)
		var ok = true
		for p in snake.positions:
			if p == pos: 
				ok = false
				break
			if ok:
				return pos
	return Vector2(CELL*10,CELL*7)
				
			
