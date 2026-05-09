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
var current_bullet :BulletFactory.BulletType = BulletFactory.BulletType.NORMAL
var _bullet_proto: Bullet = null

signal player_died()
signal health_changed(current:int,max_hp:int)

func _ready() -> void:
	current_health = max_health
	health_bar.max_value = max_health
	health_bar.value = current_health
	add_to_group('player')
	if visual: visual.color = Color(0.2,0.4,1.0)
	print('[Player] ready | HP ',max_health)

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
	var dir:Vector2 = (get_global_mouse_position() - global_position).normalized()
	var bullet: Bullet;
	if _bullet_proto != null and _bullet_proto.scene_file_path != "":
		bullet = BulletPrototype.clone(_bullet_proto,global_position,dir)
	else:
		bullet = BulletFactory.create(current_bullet,global_position,dir)
		_bullet_proto = bullet
	if bullet:
		get_tree().root.add_child(bullet)
		
	
func _handle_bullet_switch()->void:
	if Input.is_action_just_pressed("ui_focus_next"):
		var next = (current_bullet + 1) % 4
		current_bullet = next as BulletFactory.BulletType
		_bullet_proto = null
		_update_color()
		print('[Player] Bullet ',BulletFactory.BulletType.keys()[current_bullet])
		
func _update_color()->void:
	if not is_alive: return
	match current_bullet:
		BulletFactory.BulletType.NORMAL: visual.color = Color(0.2,0.4,1.0)
		BulletFactory.BulletType.FIRE: visual.color = Color(1.0,0.4,0.1)
		BulletFactory.BulletType.POISON: visual.color = Color(0.2,0.9,0.2)
		BulletFactory.BulletType.ICE: visual.color = Color(0.4,0.8,1.0)
		
func take_damage(amount:int)->void:
	if not is_alive: return
	current_health = clamp(current_health-amount,0,max_health)
	health_bar.value = current_health
	health_changed.emit(current_health,max_health)
	if current_health <=0:
		die()

func die()->void:
	is_alive = false
	player_died.emit()
	GameManager.trigger_game_over()
	if visual: visual.color = Color(0.3,0.3,0.3)
