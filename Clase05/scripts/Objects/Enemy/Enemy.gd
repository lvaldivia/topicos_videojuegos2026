class_name Enemy
extends CharacterBody2D

@export var max_health: int = 60
@export var speed :float =80.0
@export var damaage: int = 10
@export var score_value = int = 10
@onready var visual:ColorRect = $Visual
@onready var health_bar:ProgressBar = $HealthBar
var current_health : int
var is_alive: bool = true
var _dot_timer:float = 0.0
var _dot_duration:float = 0.0
var _slow_timer:float = 0.0
var _base_speed: float = 0.0

func _ready()->void:
		_setup()
		current_health = max_health
		health_bar.max_value = max_health
		health_bar.value = current_health
		_base_speed = speed
		add_to_group('enemies')

func _setup()->void:
	pass

func _process(delta: float) -> void:
	if not is_alive: return
	_process_dots(delta)
	_proces_slow(delta)
	_move_towards_player(delta)

func _move_towards_player(delta:float)->void:
	var players = get_tree().get_nodes_in_group("player")
	if players.is_empty():return
	var player:Player = players[0]
	var dir:Vector2 = (player.global_position - global_position).normalized()
	velocity = dir * speed
	move_and_slide()
	
func _process_dots(delta:float)->void:
	if _dot_duration <=0: return
	_dot_duration -=delta
	_dot_timer -=delta
	if _dot_timer <= 0:
		_dot_timer = 1
		take_damage(_dot_damage)
	if _dot_duration <=0:
		modulate = Color(1,1,1)
		
func _proces_slow(delta:float)->void:
	if _slow_timer <=0: return
	_slow_timer -=delta
	if _slow_timer <=0:
		speed = _base_speed
		modulate =Color(1,1,1)
		
func take_damage(amount:int):
	if not is_alive: return
	current_health = clamp(current_health-amount,0,max_health)
	health_bar.value = current_health
	if current_health <= 0:
		die()

func die()->void:
	pass
