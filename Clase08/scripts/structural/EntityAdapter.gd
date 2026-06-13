class_name EntityAdapter
extends RefCounted

var _entity : BaseEntity
func _init(entity: BaseEntity) -> void: _entity = entity

func receive_hit(amount: int) -> void: _entity.take_damage(amount)
func get_hp()      -> int:    return _entity.current_health
func get_max_hp()  -> int:    return _entity.max_health
func is_dead()     -> bool:   return not _entity.is_alive
func get_pos()     -> Vector2:return _entity.global_position
func get_entity()  -> BaseEntity: return _entity
