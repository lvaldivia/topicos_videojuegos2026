class_name BaseEntity
extends CharacterBody2D

@export var entity_name : String = "Entity"
@export var max_health  : int    = 100
@export var speed       : float  = 150.0

@onready var visual     : ColorRect   = $Visual
@onready var health_bar : ProgressBar = $HealthBar

var current_health : int
var is_alive       : bool = true

signal health_changed(current: int, max_hp: int)
signal entity_died(who: BaseEntity)

func _ready() -> void:
	_setup()
	current_health       = max_health
	health_bar.max_value = max_health
	health_bar.value     = current_health

func _setup() -> void: pass

func take_damage(amount: int) -> void:
	if not is_alive: return
	current_health   = clamp(current_health - amount, 0, max_health)
	health_bar.value = current_health
	health_changed.emit(current_health, max_health)
	if current_health <= 0: die()

func die() -> void:
	is_alive = false
	entity_died.emit(self)
	if visual: visual.color = Color(0.4, 0.4, 0.4)

func heal(amount: int) -> void:
	if not is_alive: return
	current_health   = clamp(current_health + amount, 0, max_health)
	health_bar.value = current_health
	health_changed.emit(current_health, max_health)
