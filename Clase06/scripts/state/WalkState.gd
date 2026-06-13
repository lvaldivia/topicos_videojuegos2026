class_name WalkState
extends CharacterState


func enter()->void:
	if owner_node.has_node('Visual'):
		owner_node.get_node('Visual').color = Color(0.2,0.9,0.2)
	if owner_node.has_node('StateLabel'):
		owner_node.get_node('StateLabel').text = 'WALK'

func update(delta:float)->void:
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	owner_node.velocity = dir * 160.0
	owner_node.move_and_slide()
	
func get_next()->CharacterState:
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if dir == Vector2.ZERO:
		var s = IdleState.new();
		s.owner_node = owner_node;
		return s
	if Input.is_action_just_pressed('attack'):
		var s = AttackState.new();
		s.owner_node = owner_node;
		return s
	return null
