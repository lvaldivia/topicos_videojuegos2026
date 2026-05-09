extends Node


var facade:GameFacade = GameFacade.new()

func _ready() -> void:
	add_child(facade)
	facade.setup(self)
	var player: Player = facade.spawn_player()
	await get_tree().create_timer(0.5).timeout
	print('comenzar olas')
