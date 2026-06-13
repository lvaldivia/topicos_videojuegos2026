class_name AttackState
extends CharacterState

var _timer: float = 0.0
var _duration: float = 0.6


func enter()->void:
	_timer = 0.0
	owner_node.velocity = Vector2.ZERO
	if owner_node.has_node('Visual'):
		owner_node.get_node('Visual').color = Color(1.0,0.4,0.0)
	if owner_node.has_node('StateLabel'):
		owner_node.get_node('StateLabel').text = 'ATTACK'

func update(delta:float)->void:
	_timer+=delta
	owner_node.move_and_slide()
	
func get_next()->CharacterState:
	if _timer >= _duration:
		var s = IdleState.new()
		s.owner_node = owner_node
		return s
	return null
		
