class_name Goblin
extends Enemy

func _setup() -> void:
	character_name = "Goblin"
	max_health = 60
	damanage = 10
	speed = 160.0
	attack_range = 45.0
	attack_cooldown = 0.9
	
func take_damage(amount: int) -> void:
	print('hola esto es danio')
	super.take_damage(int(amount*0.75))
