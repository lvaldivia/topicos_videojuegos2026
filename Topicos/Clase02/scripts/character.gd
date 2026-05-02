class_name Character
extends CharacterBody2D

@export var character_name : String = "Unknown"
@export var max_health : int = 100
@export var speed : float = 150.0
@export var damanage : int = 10

#var sprite :AnimatedSprite2D = get_node("AnimatedSprite2D")
#siempre se debe llamar a los hijos en el ready
#opcion 1 dar el valor en el _ready
#opcion 2 con @onready
#@onready var sprite :AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var sprite : AnimatedSprite2D = $Animation
@onready var health_bar : ProgressBar = $HealthBar

var currenth_health : int
var is_alive : bool = true

signal health_changed(new_health:int, max_hp:int)
signal character_died(who:Character)

func _ready() -> void:
	#sprite =  get_node("AnimatedSprite2D")
	#sprite =  $Animation
	_setup()
	currenth_health = max_health
	health_bar.max_value = max_health
	health_bar.value = currenth_health
	
	
func _setup()->void:
	push_warning("_setup no implementado")

func move(delta:float)->void:
	push_warning("move no implementado")
	
func take_damage(amount:int) ->void:
	if not is_alive: return
	currenth_health = clamp(currenth_health - amount,0,max_health)
	health_bar.value = currenth_health
	emit_signal("health_changed",currenth_health,max_health)
	if currenth_health <= 0:
		die()
		
func die()->void:
	is_alive = false
	sprite.play("death")
	emit_signal("character_died",self)
	await sprite.animation_finished
	queue_free()
