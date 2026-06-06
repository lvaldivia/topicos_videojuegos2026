# DECORATOR — EntityDecorator.gd
# Agrega efectos temporales a una entidad sin modificar su clase.
# Llamar update(delta) en _process() para que el timer funcione.
# USO: var d = EntityDecorator.SpeedBoost.new(entity, 1.5, 5.0)
#      add_child(d)
class_name EntityDecorator
extends Node

# ── Efecto base ───────────────────────────────────────────
class Effect extends RefCounted:
	var _entity   : BaseEntity
	var _duration : float
	var _elapsed  : float = 0.0

	func _init(entity: BaseEntity, duration: float) -> void:
		_entity = entity; _duration = duration

	func update(delta: float) -> bool:  # retorna true cuando termina
		_elapsed += delta
		return _elapsed >= _duration

	func on_start() -> void: pass
	func on_end()   -> void: pass

# ── SpeedBoost ────────────────────────────────────────────
class SpeedBoost extends Effect:
	var _multiplier : float
	var _base_speed : float

	func _init(entity: BaseEntity, multiplier: float, duration: float) -> void:
		super._init(entity, duration)
		_multiplier = multiplier
		_base_speed = entity.speed

	func on_start() -> void:
		_entity.speed *= _multiplier
		if _entity.has_node("Visual"):
			_entity.get_node("Visual").color = Color(0.4, 0.8, 1.0)

	func on_end() -> void:
		_entity.speed = _base_speed
		if _entity.has_node("Visual"):
			_entity.get_node("Visual").color = Color.WHITE

# ── PoisonEffect ──────────────────────────────────────────
class PoisonEffect extends Effect:
	var _dps       : int
	var _tick      : float = 0.0

	func _init(entity: BaseEntity, dps: int, duration: float) -> void:
		super._init(entity, duration); _dps = dps

	func on_start() -> void:
		if _entity.has_node("Visual"):
			_entity.get_node("Visual").color = Color(0.3, 1.0, 0.3)

	func update(delta: float) -> bool:
		_tick += delta
		if _tick >= 1.0:
			_tick = 0.0
			_entity.take_damage(_dps)
		return super.update(delta)

	func on_end() -> void:
		if _entity.has_node("Visual"):
			_entity.get_node("Visual").color = Color.WHITE

# ── Aplicar efectos desde fuera ───────────────────────────
var _effects : Array = []

func apply(effect: Effect) -> void:
	effect.on_start()
	_effects.append(effect)

func _process(delta: float) -> void:
	for i in range(_effects.size() - 1, -1, -1):
		if _effects[i].update(delta):
			_effects[i].on_end()
			_effects.remove_at(i)
