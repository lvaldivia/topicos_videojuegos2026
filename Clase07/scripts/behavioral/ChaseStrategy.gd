class_name ChaseStrategy
extends AIStrategy

var target_group : String = "player"

func execute(entity: BaseEntity, _delta: float) -> void:
	var target = find_in_group(entity, target_group)
	if not target:
		entity.velocity = Vector2.ZERO
		return
	var dir        = (target.global_position - entity.global_position).normalized()
	entity.velocity = dir * entity.speed
	entity.move_and_slide()
	if entity.has_node("Visual"):
		entity.get_node("Visual").color = Color(0.9, 0.2, 0.2)

func get_name() -> String: return "CHASE"
