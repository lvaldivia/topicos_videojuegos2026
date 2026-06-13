class_name EntityPrototype
extends RefCounted

static func clone(original: BaseEntity, nueva_pos: Vector2) -> BaseEntity:
	var path = original.scene_file_path
	if path.is_empty(): return null
	var c : BaseEntity = load(path).instantiate()
	c.entity_name  = original.entity_name + " (clon)"
	c.max_health   = original.max_health
	c.speed        = original.speed
	c.position     = nueva_pos
	return c
