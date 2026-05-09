class_name Player
extends CharacterBody2D

@export var speed: float = 200.0
@export var max_health : int = 100
@export var fire_rate: float = 0.2

@onready  var visual: ColorRect = $Visual
@onready var health_bar :ProgressBar = $HealthBar

var current_health : int = 0
var is_alive : bool = true
var _fire_timer :float = 0.0
var current_bullet
var _bullet_proto

signal player_died()
signal health_changed(current:int,max_hp:int)

func _process(delta: float) -> void:
	if not is_alive: return
	_move(delta)
	_handle_shoot(delta)
	_handle_bullet_switch()
	
func _move(delta:float)->void:
	var dir = Input.get_vector("ui_left",'ui_right','ui_up','ui_down')
	velocity = dir * speed
	move_and_slide()
	look_at(get_global_mouse_position())

func _handle_shoot(delta:float)->void:
	_fire_timer -=delta
	if Input.is_action_just_pressed("shoot") and _fire_timer <=0:
		_fire_timer = fire_rate
		_shoot()
	
func _shoot()->void:
	pass
	
func _handle_bullet_switch()->void:
	pass
