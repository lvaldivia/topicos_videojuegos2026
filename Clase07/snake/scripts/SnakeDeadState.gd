class_name SnakeDeadState
extends EntityState

func enter()               -> void:
	owner_node.velocity = Vector2.ZERO
	if owner_node.has_node("Visual"):
		owner_node.get_node("Visual").color = Color(0.85,0.1,0.1)
	#gameover
	
func get_name() -> String:
	return "DEAD"
