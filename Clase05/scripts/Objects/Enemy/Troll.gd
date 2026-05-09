class_name Troll 
extends Enemy

func _setup()->void:
	max_health = 200
	speed = 50.0
	damage = 25
	score_value = 30
	
func take_damage(amount:int)->void:
	super.take_damage(int(amount*0.7))
