class_name Warrior
extends Character

var shield_block_change : float = 0.3
var is_raging : bool = false

func _setup() -> void:
	add_to_group("warriors")
	character_name  = "Warrior"
	max_health      = 150
	damanage        = 20
	speed           = 120.0
	# BUG FIX: NO llamar sprite.play() aquí
	# La clase base character.gd lo hace al final de _ready()

func move(delta: float) -> void:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * speed
	move_and_slide()
	# Cambiar animación según movimiento
	if sprite.sprite_frames:
		var anim = "walk" if dir != Vector2.ZERO else "idle"
		if sprite.animation != anim:
			sprite.play(anim)
	# Voltear sprite según dirección horizontal
	if dir.x != 0:
		sprite.flip_h = dir.x < 0

func take_damage(amount: int) -> void:
	super.take_damage(amount)
	if currenth_health < max_health * 0.3 and not is_raging and is_alive:
		activate_rage()

func activate_rage() -> void:
	is_raging = true
	damanage  += 15
	sprite.modulate = Color(1.5, 0.5, 0.5)
	print(">>> Warrior entra en RABIA! Daño:", damanage)
