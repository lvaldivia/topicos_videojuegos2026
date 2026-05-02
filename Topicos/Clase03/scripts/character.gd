class_name Character
extends CharacterBody2D

@export var character_name : String = "Unknown"
@export var max_health : int = 100
@export var speed : float = 150.0
@export var damanage : int = 10

@onready var sprite      : AnimatedSprite2D = $Animation
@onready var health_bar  : ProgressBar      = $HealthBar

var currenth_health : int
var is_alive : bool = true

signal health_changed(new_health:int, max_hp:int)
signal character_died(who:Character)

func _ready() -> void:
	_setup()
	currenth_health = max_health
	health_bar.max_value = max_health
	health_bar.value     = currenth_health
	# Reproducir animación idle si existe
	if sprite.sprite_frames and sprite.sprite_frames.has_animation("idle"):
		sprite.play("idle")

func _process(delta: float) -> void:
	if is_alive:
		move(delta)

# --- Métodos a sobreescribir en subclases ---
func _setup() -> void:
	pass

func move(delta: float) -> void:
	pass

# --- Lógica de combate ---
func take_damage(amount: int) -> void:
	if not is_alive:
		return
	currenth_health = clamp(currenth_health - amount, 0, max_health)
	health_bar.value = currenth_health
	emit_signal("health_changed", currenth_health, max_health)
	if sprite.sprite_frames and sprite.sprite_frames.has_animation("hurt"):
		sprite.play("hurt")
	if currenth_health <= 0:
		die()

func die() -> void:
	is_alive = false
	emit_signal("character_died", self)
	# BUG FIX: verificar que la animación "death" exista antes de reproducirla
	if sprite.sprite_frames and sprite.sprite_frames.has_animation("death"):
		sprite.play("death")
		await sprite.animation_finished
	else:
		modulate = Color(1, 0, 0, 0.5)
		await get_tree().create_timer(0.5).timeout
	queue_free()
