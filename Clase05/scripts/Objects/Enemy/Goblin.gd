class_name Goblin 
extends Enemy

func _setup()->void:
	max_health = 60
	speed = 100.0
	damage = 10
	score_value = 10
	if visual: visual.color = Color(0.2,0.8,0.2)
	
