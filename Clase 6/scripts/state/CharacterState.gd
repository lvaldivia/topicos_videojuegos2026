class_name CharacterState
extends RefCounted

var owner_node: CharacterBody2D

func enter()->void:pass
func exit()->void:pass
func update(_detal:float) ->void:pass
func get_next() ->CharacterState: return null
