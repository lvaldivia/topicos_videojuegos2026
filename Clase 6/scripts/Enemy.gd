extends CharacterBody2D

@export var max_health:int = 100
@export var damage :int = 15
@export var attack_range: float = 50.0
@export var attack_rate: float = 1.2

@onready var visual: ColorRect = $Visual
@onready var health_bar:ProgressBar = $HealthBar
@onready var state_label:Label = $StateLabel

var current_health:int
var is_alive: bool = true
var _atk_time:float = 0.0
var ai_strategy : AIStrategy = null

func _ready() -> void:
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	set_strategy(PatrolStrategy.new())
	
func _process(delta: float) -> void:
	if not is_alive:return
	_atk_time -=delta
	if ai_strategy:
		ai_strategy.execute(self,delta)
		state_label.text = ai_strategy.get_name()

func set_strategy(strategy:AIStrategy)->void:
	ai_strategy = strategy
