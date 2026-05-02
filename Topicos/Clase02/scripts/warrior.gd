class_name Warrior
extends Character

var shield_block_change : float = 0.3
var is_raging : bool = false

func _setup()->void:
	character_name = "Warrior"
	max_health = 150
	damanage = 20
	speed = 120.0
	currenth_health = max_health
	sprite.play("idle")  # ← agrega esto


func _process(delta: float) -> void:
	if is_alive:
		move(delta)

func move(delta:float)->void:
	var dir = Input.get_vector("ui_left",'ui_right',"ui_up","ui_down")
	velocity = dir * speed
	sprite.play("walk" if dir != Vector2.ZERO else "idle")
	move_and_slide()
	
func take_damage(amount:int) ->void:
	super.take_damage(amount)
	if currenth_health < 30 and not is_raging:
		activate_rage()

func  activate_rage()->void:
	is_raging = true
	damanage +=15
	sprite.modulate = Color(1.5,0.5,0.5)

	
