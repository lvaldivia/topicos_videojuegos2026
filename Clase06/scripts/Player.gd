extends CharacterBody2D

@export var max_health:int = 100
@onready var visual: ColorRect = $Visual
@onready var health_bar:ProgressBar = $HealthBar
@onready var state_label:Label = $StateLabel

var current_health : int
var is_alive : bool = true
var current_state:CharacterState = null

signal health_changed(current:int,max_hp:int)
signal state_changed(state_name:String)

func _ready() -> void:
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	add_to_group('player')
	_change_state(IdleState.new())
	
func _process(delta: float) -> void:
	if not is_alive or current_state == null: return
	current_state.update(delta)
	var next = current_state.get_next()
	if next:
		_change_state(next)
		
func _change_state(new_state:CharacterState)->void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.owner_node = self
	current_state.enter()
	state_changed.emit(new_state.get_script().resource_path.get_file().replace(".gd",""))

func take_damage(amount:int)->void:
	if not is_alive: return
	current_health = clamp(current_health-amount,0,max_health)
	health_bar.value = current_health
	health_changed.emit(current_health,max_health)
	if current_health <=0:
		is_alive = false
		_change_state(DeadState.new())
		
