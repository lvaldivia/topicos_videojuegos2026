extends Node2D


@onready var hud:CanvasLayer = $HUD
@onready var player:CharacterBody2D = $Player
@onready var enemy:CharacterBody2D = $Enemy


var _strategies:Array = []
var _strat_idx :int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.state_changed.connect(hud.on_state_changed)
	player.health_changed.connect(hud.on_hp_changed)
	hud.on_hp_changed(player.max_health,player.max_health)
	hud.on_state_changed("IdleState")
	hud.set_strategy("PATROL")
	_strategies = [PatrolStrategy.new(),FleeStrategy.new(),ChaseStrategy.new()] 

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_TAB:
				_strat_idx = (_strat_idx + 1) % _strategies.size()
				var strat = _strategies[_strat_idx]
				enemy.set_strategy(strat)
				hud.set_strategy(strat.get_name())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
