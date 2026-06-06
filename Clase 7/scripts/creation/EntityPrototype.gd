# PROTOTYPE — EntityPrototype.gd
# Clona una entidad existente copiando sus stats actuales.
# Diferencia con Factory: Factory crea desde base, Prototype copia el estado actual.
# USO: var clon = EntityPrototype.clone(original, nueva_pos)
class_name EntityPrototype
extends RefCounted

static func clone(original: BaseEntity, nueva_pos: Vector2) -> BaseEntity:
	var path = original.scene_file_path
	if path.is_empty():
		push_error("EntityPrototype: el nodo no tiene scene_file_path. Solo funciona con nodos instanciados desde .tscn")
		return null
	var clon : BaseEntity = load(path).instantiate()
	clon.entity_name  = original.entity_name + " (clon)"
	clon.max_health   = original.max_health
	clon.speed        = original.speed
	clon.position     = nueva_pos
	return clon

static func clone_many(original: BaseEntity, positions: Array[Vector2]) -> Array[BaseEntity]:
	var result : Array[BaseEntity] = []
	for pos in positions:
		var c = clone(original, pos)
		if c: result.append(c)
	return result
