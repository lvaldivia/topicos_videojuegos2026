class_name IdleEntityState
extends EntityState

func enter() -> void:
	owner_node.velocity = Vector2.ZERO
	if owner_node.has_node("Visual"):
		owner_node.get_node("Visual").color = Color(0.2, 0.5, 1.0)

func update(_delta: float) -> void:
	owner_node.move_and_slide()

func get_name() -> String: return "IDLE"
# get_next() retorna null por defecto — sobreescribir para agregar transiciones
