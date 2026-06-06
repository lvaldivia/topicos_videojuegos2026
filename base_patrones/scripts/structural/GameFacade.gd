# FACADE — GameFacade.gd
# Simplifica el sistema completo a llamadas de una sola linea.
# Main.gd solo habla con el Facade — no conoce Factory, Builder ni GameManager.
# USO: add_child(facade) en _ready(), luego facade.spawn_entity(...)
class_name GameFacade
extends Node

var _parent   : Node
var _entities : Array[BaseEntity] = []

signal entity_spawned(entity: BaseEntity)
signal all_entities_dead()

func setup(parent: Node) -> void:
	_parent = parent
	GameManager.reset()

# Crear y agregar una entidad con una sola llamada
func spawn_entity(scene: PackedScene, pos: Vector2) -> BaseEntity:
	var e : BaseEntity = scene.instantiate()
	_parent.add_child(e)
	e.global_position = pos
	e.entity_died.connect(_on_entity_died)
	_entities.append(e)
	entity_spawned.emit(e)
	return e

# Crear entidad configurada con Builder
func spawn_configured(scene: PackedScene, pos: Vector2,
		hp: int = -1, spd: float = -1.0, color: Color = Color.WHITE) -> BaseEntity:
	var b = EntityBuilder.new().from_scene(scene).set_position(pos)
	if hp   != -1:   b.set_health(hp)
	if spd  != -1.0: b.set_speed(spd)
	b.set_color(color)
	var e = b.build()
	if e:
		_parent.add_child(e)
		e.global_position = pos
		e.entity_died.connect(_on_entity_died)
		_entities.append(e)
	return e

func get_entities_in_group(group: String) -> Array[BaseEntity]:
	return _entities.filter(func(e): return e.is_in_group(group)) as Array[BaseEntity]

func clear_all() -> void:
	for e in _entities:
		if is_instance_valid(e): e.queue_free()
	_entities.clear()

func get_status() -> Dictionary:
	return {
		"score"    : GameManager.score,
		"level"    : GameManager.current_level,
		"entities" : _entities.size(),
		"game_over": GameManager.is_game_over,
	}

func _on_entity_died(who: BaseEntity) -> void:
	_entities.erase(who)
	if _entities.is_empty():
		all_entities_dead.emit()
