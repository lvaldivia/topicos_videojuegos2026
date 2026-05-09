class_name GameFacade
extends Node

var _parent:Node
var _player:Player = null

func setup(parent:Node)->void:
	_parent = parent
	GameManager.reset()
	print('[Facade] Game init')
	
func spawn_player(pos:Vector2 = Vector2(320,190))->Player:
	_player = load("res://scenes/characters/Player.tscn").instantiate()
	_parent.add_child(_player)
	_player.global_position = pos
	print('[Facade] Player spawn')
	return _player
