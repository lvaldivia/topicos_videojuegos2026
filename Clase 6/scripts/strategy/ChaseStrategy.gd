class_name ChaseStrategy

extends AIStrategy
func execute(_enemy:CharacterBody2D,_delta:float)->void:
	var player = find_player(_enemy)
	if not player:
		_enemy.velocity= Vector2.ZERO
		return
	var dir = ( player.global_position - _enemy.global_position).normalized()
	_enemy.velocity = dir * 120.0
	_enemy.move_and_slide()
	if _enemy.has_node('Visual'):
		_enemy.get_node('Visual').color = Color(0.9,0.2,0.2)

func get_name()->String: return "CHASE"
