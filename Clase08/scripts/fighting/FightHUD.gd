class_name FightHUD
extends BaseHUD

@onready var player_hp_bar  : ProgressBar = $PlayerHPBar
@onready var cpu_hp_bar     : ProgressBar = $CPUHPBar
@onready var timer_label    : Label = $TimerLabel
@onready var round_label    : Label = $RoundLabel
@onready var message_label  : Label = $MessageLabel
@onready var strategy_label : Label = $StrategyLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.round_time_changed.connect(on_time_changed)
	GameManager.round_started.connect(on_round_started)
	GameManager.round_ended.connect(on_round_ended)
	GameManager.wins_changed.connect(on_wins_changed)
	if message_label:
		message_label.visible = false

func on_round_ended(winner:String)->void:
	var text = "K.O"
	match winner:
		'player','time_player': text = "Ganaste!"
		'cpu','time_cpu':text = "Perdiste"
		'draw': text = "Empate"
	text += "\n\n Enter para continuar"
	_show_message(text,999.0)

func on_wins_changed(p:int,c:int)->void:
	if round_label:
		round_label.text  = "Jugador "+str(p)+" - "+str(c) + " CPU"

func on_time_changed(t:int)->void:
	if timer_label:
		timer_label.text = str(t)

func on_round_started(r:String)->void:
	_show_message("ROUND "+str(r),1.2)
	
func _show_message(text:String,duration:float)->void:
	if not message_label:return
	message_label.text = text
	message_label.visible = true
	if duration < 900.0:
		await get_tree().create_timer(duration).timeout
		message_label.visible = false
	
func on_player_hp(current:int,max_hp:int)->void:
	if player_hp_bar:
		player_hp_bar.max_value =max_hp
		player_hp_bar.value = current
		
func on_cpu_hp(current:int,max_hp:int)->void:
	if cpu_hp_bar:
		cpu_hp_bar.max_value =max_hp
		cpu_hp_bar.value = current
		
func on_cpu_strategy(strategy_name:String)->void:
	if strategy_label:
		strategy_label.text = "IA CPU :" + strategy_name
	
func hide_message()->void:
	if message_label:
		message_label.visible = false
