class_name PlayerFighter
extends EntityWithState


@export var is_player_controlled : bool = true
@export var light_damage		 : int = 8
@export var heavy_damage 		 : int = 15
@export var jump_force 			 : float = -380.0
@export var gravity    			 :float = 900.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

var facing: int = 1
var is_blocking : bool = false
var ground_y: float = 0.0
var oponent:PlayerFighter = null
var ai_strategy: AIStrategy = null
var _special_timer: float= 0.0
var ai_input:Dictionary = {
	"move":0.0,
	"jump" :false,
	"light":false,
	"heavy":false,
	"block":false,
	"special":false
}
signal hit_landed(damage:int)
signal project_fired()

func _ready() -> void:
	super._ready()
	ground_y = global_position.y
	_change_state(FighterIdleScene.new())

func _setup() -> void:
	add_to_group("fighters")

func _process(delta: float) -> void:
	super._process(delta)
	_special_timer -=delta
	if ai_strategy != null and not is_player_controlled:
		ai_strategy.execute(self,delta)
	_face_oponent()
	if anim:
		anim.flip_h = facing < 0


func set_ai_strategy(strategy:AIStrategy)->void:
	ai_strategy = strategy
	
func get_input() ->Dictionary:
	print(is_player_controlled)
	if is_player_controlled:
		return{
			"move" : Input.get_axis("p1_left","p1_right"),
			"jump" : Input.is_action_just_pressed("p1_jump"),
			"light" : Input.is_action_just_pressed("p1_light"),
			"heavy" : Input.is_action_just_pressed("p1_heavy"),
			"block" : Input.is_action_just_pressed("p1_block"),
			"special" : Input.is_action_just_pressed("p1_special"),
		}
	var i = ai_input.duplicate()
	ai_input.jump = false
	ai_input.light = false
	ai_input.heavy = false
	ai_input.block = false
	ai_input.special = false
	return i
	
func apply_gravity(delta:float)->void:
	velocity.y += gravity * delta
	if global_position.y >= ground_y and velocity.y > 0:
		global_position.y = ground_y
		velocity.y = 0.0
		
func _face_oponent()->void:
	if oponent and is_instance_valid(oponent):
		if oponent.global_position.x > global_position.x:
			facing = 1
		else:
			facing = -1

func can_fire_special()->bool:
	return _special_timer <=0.0
	
func fire_projectile() ->void:
	if not can_fire_special():return
	_special_timer = 1.2
	var spawn_pos = global_position + Vector2(facing*30,-45)
	var p = ProjectileFactory.create_projectile(spawn_pos,facing,self)
	get_parent().add_child(p)
	project_fired.emit()
	
func do_hit(target:PlayerFighter, dmg:int)->void:
	if target and is_instance_valid(target) and target.is_alive:
		target.take_damage(dmg)
		hit_landed.emit(dmg)
	
func take_damage(amount: int,_attacker = null,apply_hitstunt:bool =false) -> void:
	if not is_alive:return
	var dmg = amount
	if is_blocking:
		dmg = int(amount*0.2)
	current_health = clamp(current_health - dmg,0,max_health)
	health_bar.value = current_health
	health_changed.emit(current_health,max_health)
	if current_health <= 0:
		_change_state(FighterKOState.new())
		entity_died.emit(self)
	elif dmg > 0 and apply_hitstunt:
		_change_state(FighterHitStunState.new())
	
	
