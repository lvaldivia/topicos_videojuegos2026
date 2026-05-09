class_name BulletPrototype
extends RefCounted

static func clone(original:Bullet,pos:Vector2,dir:Vector2)->Bullet:
	var path = original.scene_file_path
	if path.is_empty():
		push_error("[Protype] No file_path")
		return null
	var clon:Bullet = load(path).instantiate()
	clon.speed = original.speed
	clon.damage = original.damage
	clon.position = pos
	clon.direction = dir.normalized()
	print("[Prototype] Bullet cloned ",original.get_class())
	return clon
