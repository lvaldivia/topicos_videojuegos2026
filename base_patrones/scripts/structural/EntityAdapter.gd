# ADAPTER — EntityAdapter.gd
# Traduce la interfaz de BaseEntity a la que espera un sistema externo.
# USO: var adapter = EntityAdapter.new(mi_entidad)
#      adapter.receive_hit(20)   <- en lugar de entity.take_damage(20)
class_name EntityAdapter
extends RefCounted

var _entity : BaseEntity

func _init(entity: BaseEntity) -> void:
	_entity = entity

# Traducciones — sistema externo → BaseEntity
func receive_hit(amount: int)  -> void:   _entity.take_damage(amount)
func get_hp()                  -> int:    return _entity.current_health
func get_max_hp()              -> int:    return _entity.max_health
func is_dead()                 -> bool:   return not _entity.is_alive
func get_entity_name()         -> String: return _entity.entity_name
func get_pos()                 -> Vector2:return _entity.global_position
func restore(amount: int)      -> void:   _entity.heal(amount)
func get_entity()              -> BaseEntity: return _entity
