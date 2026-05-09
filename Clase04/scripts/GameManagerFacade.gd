class_name GameManagerFacade
extends Node2D

var facade:GameFacade = GameFacade.new()

func _ready() -> void:
	facade.setup(self,get_tree())
	facade.spawn_player(Vector2(320,180))
	await get_tree().create_timer(0.5).timeout
	facade.start_wave(1)
	
	await get_tree().create_timer(4).timeout
	facade.apply_effect(facade.player,'poison')
	
func _process(delta: float) -> void:
	facade._process(delta)
