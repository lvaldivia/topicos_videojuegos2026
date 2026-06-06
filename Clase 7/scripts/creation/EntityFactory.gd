# FACTORY METHOD — EntityFactory.gd
# Centraliza la creacion de entidades por tipo.
# Para agregar un tipo nuevo: anadir al enum + al diccionario SCENES.
# USO: var e = EntityFactory.create(EntityFactory.Type.PLAYER, pos)
class_name EntityFactory
extends Node

enum Type {
	PLAYER,
	ENEMY,
	FOOD,
	# Agrega tus tipos aqui
}

# Cargar tus escenas aqui con preload()
# const SCENES : Dictionary = {
#     Type.PLAYER : preload("res://scenes/Player.tscn"),
#     Type.ENEMY  : preload("res://scenes/Enemy.tscn"),
#     Type.FOOD   : preload("res://scenes/Food.tscn"),
# }

static func create(type: Type, pos: Vector2) -> BaseEntity:
	# Reemplazar con: var e = SCENES[type].instantiate()
	push_warning("EntityFactory: agrega tus escenas en SCENES")
	return null

static func create_group(types: Array[Type], positions: Array[Vector2]) -> Array[BaseEntity]:
	var result : Array[BaseEntity] = []
	for i in types.size():
		var e = create(types[i], positions[i % positions.size()])
		if e: result.append(e)
	return result
