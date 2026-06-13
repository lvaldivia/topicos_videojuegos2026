class_name FleeFromSnakeStrategy
extends AIStrategy

const CELL :int = 32
const GRID_W : int = 20
const GRID_H : int = 15
var _timer : float = 15

func execute(_entity: BaseEntity, _delta: float) -> void:
	_timer -= _delta
	if _timer > 0.0: return
	_timer = 0.8
	var snake = find_in_group(_entity,'player')
	if not snake: return
	var dir = (_entity.global_position - snake.global_position).normalized()
	var best = Vector2.RIGHT
	var best_dot = -2.0
	var dirs = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]
	for d  in dirs:
		var dot = dir.dot(d)
		if dot > best_dot: 
			best_dot = dot
			best = d
			
	var np = _entity.global_position + best * CELL
	if np.x >= 0 and np.x < GRID_W * CELL and np.y >=0 and np.y < GRID_H * CELL:
		_entity.global_position = np
		
func get_name() -> String:
	return "FLEE"
		
