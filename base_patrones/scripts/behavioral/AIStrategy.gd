# STRATEGY — Clase base de todas las estrategias de IA
# El Enemy llama ai_strategy.execute(self, delta) en cada frame.
# Alguien externo (Main.gd) llama entity.set_strategy() para cambiarla.
class_name AIStrategy
extends RefCounted

func execute(_entity: BaseEntity, _delta: float) -> void:
	pass

func get_name() -> String: return "Base"

func find_in_group(entity: BaseEntity, group: String) -> BaseEntity:
	var nodes = entity.get_tree().get_nodes_in_group(group)
	if nodes.size() > 0:
		return nodes[0] as BaseEntity
	return null
