class_name PatrolStrategy
extends AIStrategy

var _dir : float = 1.0
var _timer : float = 0.0

func execute(_enemy:CharacterBody2D,_delta:float)->void:
	_timer+=_delta
	if _timer >= 2.0:
		_timer = 0
		_dir *= -1.0
	_enemy.velocity = Vector2(_dir*80.0,0)
	_enemy.move_and_slide()
	if _enemy.has_node('Visual'):
		_enemy.get_node('Visual').color = Color(0.6,0.2,0.8)
		

func get_name()->String: return "PATROL"
