class_name EntityBuilder
extends RefCounted

var _scene     : PackedScene = null
var _nom       : String      = ""
var _hp        : int         = -1
var _spd       : float       = -1.0
var _color     : Color       = Color.WHITE
var _pos       : Vector2     = Vector2.ZERO
var _use_color : bool        = false
var _tags      : Array[String] = []

func from_scene(scene: PackedScene) -> EntityBuilder:
	_scene = scene
	return self

func set_name(n: String) -> EntityBuilder:
	_nom = n
	return self

func set_health(hp: int) -> EntityBuilder:
	_hp = hp
	return self

func set_speed(s: float) -> EntityBuilder:
	_spd = s
	return self

func set_position(p: Vector2) -> EntityBuilder:
	_pos = p
	return self

func set_color(c: Color) -> EntityBuilder:
	_color = c
	_use_color = true
	return self

func add_tag(tag: String) -> EntityBuilder:
	_tags.append(tag)
	return self

func build() -> BaseEntity:
	if _scene == null:
		return null
	var e : BaseEntity = _scene.instantiate()
	e._setup()
	if _nom != "":
		e.entity_name = _nom
	if _hp != -1:
		e.max_health = _hp
	if _spd != -1.0:
		e.speed = _spd
	if _use_color and e.has_node("Visual"):
		e.get_node("Visual").color = _color
	e.position = _pos
	for tag in _tags:
		e.add_to_group(tag)
	return e
