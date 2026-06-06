# STATE — Clase base de todos los estados
# owner_node se asigna en _change_state() ANTES de llamar enter()
class_name EntityState
extends RefCounted

var owner_node : BaseEntity

func enter()               -> void: pass
func exit()                -> void: pass
func update(_delta: float) -> void: pass
func get_next() -> EntityState:     return null
func get_name() -> String:          return "BaseState"
