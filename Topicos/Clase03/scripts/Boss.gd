class_name Boss
extends Enemy

func _setup() -> void:
	character_name = "Boss"
	max_health = 60
	damanage = 10
	speed = 160.0
	attack_range = 45.0
	attack_cooldown = 0.9
