class_name ActiveEntityState
extends EntityState

func enter() -> void:
	if owner_node.has_node("Visual"):
		owner_node.get_node("Visual").color = Color(0.2, 0.85, 0.2)

func update(_delta: float) -> void:
	owner_node.move_and_slide()

func get_name() -> String: return "ACTIVE"
