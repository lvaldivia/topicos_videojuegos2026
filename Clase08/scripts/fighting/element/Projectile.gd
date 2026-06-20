class_name Projectile
extends BaseEntity

@export var proj_speed :float = 320.0
@export var damage: int = 12

var direction: int = 1
var owner_fighter : PlayerFighter = null

@onready var anim:AnimatedSprite2D = $AnimatedSprite2D

func _setup() -> void:
	max_health = 1
	add_to_group("projectiles")
	
func _process(delta: float) -> void:
	global_position.x += direction * proj_speed * delta
	if anim:
		anim.flip_h = direction < 0
	if global_position.x < -60.0 or global_position.x > 900.0:
		queue_free()
		return
	_check_hit()

func _check_hit()->void:
	return
