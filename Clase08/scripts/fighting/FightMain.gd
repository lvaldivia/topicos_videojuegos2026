extends Node2D

const ROUND_TIME :float = 60.0
var facade :GameFacade = GameFacade.new()
const Player_Scene:PackedScene = preload("res://scenes/fighting/PlayerFighter.tscn")
const CPU_Scene:PackedScene = preload("res://scenes/fighting/CPUFighter.tscn")
@onready var hud:FightHUD = $HUD


var player:PlayerFighter;
var cpu:PlayerFighter;

func _ready() -> void:
	add_child(facade)
	facade.setup(self)
	player = facade.spawn_built(Player_Scene,Vector2(200,300),100,130.0) as PlayerFighter
	cpu = facade.spawn_built(CPU_Scene,Vector2(600,300),100,110.0) as PlayerFighter
	player.is_player_controlled = true
	player.health_changed.connect(hud.on_player_hp)
	player.entity_died.connect(on_fighter_died)
	cpu.is_player_controlled = false
	cpu.health_changed.connect(hud.on_cpu_hp)
	cpu.entity_died.connect(on_fighter_died)
	player.oponent = cpu
	cpu.oponent = player
	GameManager.reset()
	hud.on_player_hp(player.max_health,player.max_health)
	hud.on_cpu_hp(cpu.max_health,cpu.max_health)
	hud.on_wins_changed(0,0)
	GameManager.start_round(ROUND_TIME)
	
func on_fighter_died(who:BaseEntity)->void:
	if GameManager.is_game_over:return
	if who == cpu:
		GameManager.end_round("player")
	if who == player:
		GameManager.end_round("cpu")

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		if Input.is_action_just_pressed("ui_accept"):
			_continue()
		return
	if GameManager.tick_round(delta):
		_decide_by_time()
	_update_cpu_strategy()
	
func _continue()->void:
	if GameManager.player_wins >=2 or GameManager.cpu_wins >=2:
		get_tree().reload_current_scene()
		return
	GameManager.next_round()
	_reset_fighter()
	hud.hide_message()
	GameManager.start_round(ROUND_TIME)
	
func _decide_by_time()->void:
	if GameManager.is_game_over:return
	GameManager.end_round('time_player')
	
func _reset_fighter()->void:
	_reset_one(player,Vector2(200,player.ground_y))
	_reset_one(cpu,Vector2(600,player.ground_y))
	hud.on_player_hp(player.current_health,player.max_health)
	hud.on_cpu_hp(cpu.current_health,cpu.max_health)

func _reset_one(f:PlayerFighter,pos:Vector2)->void:
	f.current_health = f.max_health
	f.is_alive = true
	f.is_blocking =false
	f.global_position = pos
	f.health_bar.value= f.max_health
	f.velocity = Vector2.ZERO
	var idle =FighterIdleScene.new()
	idle.owner_node = f
	f._change_state(idle)
	
func _update_cpu_strategy()->void:
	var desired:AIStrategy;
	desired = AgressiveStrategy.new()
	if cpu.ai_strategy == null or cpu.ai_strategy.get_name() != desired.get_name():
		cpu.set_ai_strategy(desired)
		hud.on_cpu_strategy(desired.get_name())
		
