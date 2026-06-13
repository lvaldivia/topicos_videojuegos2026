class_name EntityFactory
extends Node

static func create(_scene: PackedScene, pos: Vector2) -> BaseEntity:
	var e : BaseEntity = _scene.instantiate()
	e.position = pos
	return e
