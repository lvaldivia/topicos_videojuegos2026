class_name DeadEntityState
extends EntityState

func enter() -> void:
	owner_node.velocity = Vector2.ZERO
	if owner_node.has_node("Visual"):
		owner_node.get_node("Visual").color = Color(0.4, 0.4, 0.4)
	GameManager.trigger_game_over()

func get_name() -> String: return "DEAD"
# Sin get_next() — estado final
