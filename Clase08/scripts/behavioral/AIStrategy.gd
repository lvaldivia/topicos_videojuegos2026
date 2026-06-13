class_name AIStrategy
extends RefCounted
func execute(_entity: BaseEntity, _delta: float) -> void: pass
func get_name() -> String: return "Base"
func find_in_group(entity: BaseEntity, group: String) -> BaseEntity:
	var nodes = entity.get_tree().get_nodes_in_group(group)
	return nodes[0] as BaseEntity if nodes.size() > 0 else null
