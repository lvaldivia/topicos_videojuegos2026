class_name AIStrategy
extends RefCounted

func execute(_enemy:CharacterBody2D,_delta:float)->void:
	pass

func get_name()->String:
	return "Base"
	
func find_player(enemy:CharacterBody2D)->CharacterBody2D:
	var nodes = enemy.get_tree().get_nodes_in_group("player")
	if nodes.size() > 0:
		return nodes[0] as CharacterBody2D
	return null
