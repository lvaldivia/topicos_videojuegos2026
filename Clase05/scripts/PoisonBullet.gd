class_name PoisonBullet
extends Bullet

func _ready()->void:
	speed = 300.0
	damage = 8
	color = Color(0.2,0.9,0.2)
	super._ready()
	
func _on_hit(body:Node)->void:
		#solo valida con enemigos y metodos apply poison
	if body.has_method("apply_poison"):
		#en enemigos crar apply_poison
		body.apply_poison(3,5.0) #3 de anio por segungo , 5 segundos
	body.modulate = Color(0.3,1.0,0.3)
