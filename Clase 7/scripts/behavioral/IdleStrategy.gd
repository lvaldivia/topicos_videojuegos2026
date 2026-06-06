class_name IdleStrategy
extends AIStrategy

func execute(entity: BaseEntity, _delta: float) -> void:
	entity.velocity = Vector2.ZERO
	entity.move_and_slide()

func get_name() -> String: return "IDLE"
