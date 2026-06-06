class_name DeadState
extends CharacterState

func enter()->void:
	if owner_node.has_node('Visual'):
		owner_node.get_node('Visual').color = Color(0.4,0.4,0.4)
	if owner_node.has_node('StateLabel'):
		owner_node.get_node('StateLabel').text = 'DEAD'
