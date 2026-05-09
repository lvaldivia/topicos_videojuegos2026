class_name BossEnemy 
extends Enemy

func _setup()->void:
	max_health = 500
	speed = 60
	damage = 40
	score_value = 100
	if visual: visual.color = Color(0.8,0.1,0.1)
	
