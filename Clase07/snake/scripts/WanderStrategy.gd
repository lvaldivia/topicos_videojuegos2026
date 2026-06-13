class_name WanderStrategy
extends AIStrategy

const CELL :int = 32
const GRID_W : int = 20
const GRID_H : int = 15
var _timer : float = 0.0
var _every : float = 1.5

func execute(_entity: BaseEntity, _delta: float) -> void:
	_timer -=_delta
	if _timer > 0.0: return
	_timer = _every
	var dirs = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]
	dirs.shuffle()
	for dir in dirs:
		var np = _entity.global_position + dir * CELL
		if np.x >= 0 and np.x < GRID_W * CELL and np.y >=0 and np.y < GRID_H * CELL:
			_entity.global_position = np
			break
			
func get_name() -> String:
	return "WANDER"
