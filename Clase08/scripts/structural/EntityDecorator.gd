class_name EntityDecorator
extends Node

class Effect extends RefCounted:
	var _entity   : BaseEntity
	var _duration : float
	var _elapsed  : float = 0.0

	func _init(entity: BaseEntity, duration: float) -> void:
		_entity   = entity
		_duration = duration

	func update(delta: float) -> bool:
		_elapsed += delta
		return _elapsed >= _duration

	func on_start() -> void:
		pass

	func on_end() -> void:
		pass

class SpeedBoost extends Effect:
	var _mult : float
	var _base : float

	func _init(entity: BaseEntity, mult: float, dur: float) -> void:
		super._init(entity, dur)
		_mult = mult
		_base = entity.speed

	func on_start() -> void:
		_entity.speed *= _mult

	func on_end() -> void:
		_entity.speed = _base

class PoisonEffect extends Effect:
	var _dps  : int
	var _tick : float = 0.0

	func _init(entity: BaseEntity, dps: int, dur: float) -> void:
		super._init(entity, dur)
		_dps = dps

	func update(delta: float) -> bool:
		_tick += delta
		if _tick >= 1.0:
			_tick = 0.0
			_entity.take_damage(_dps)
		return super.update(delta)

var _effects : Array = []

func apply(effect: Effect) -> void:
	effect.on_start()
	_effects.append(effect)

func _process(delta: float) -> void:
	for i in range(_effects.size() - 1, -1, -1):
		if _effects[i].update(delta):
			_effects[i].on_end()
			_effects.remove_at(i)
