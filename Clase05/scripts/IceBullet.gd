class_name IceBullet
extends Bullet

func _ready()->void:
	speed = 450.0
	damage = 5
	color = Color(0.4,0.8,1.0)
	super._ready()
	
func _on_hit(body:Node)->void:
		#solo valida con enemigos y metodos apply slow
	if body.has_method("apply_slow"):
		#en enemigos crar apply_burn
		body.apply_slow(0.4,0.2) #40% de velocidad por 2 segundos
	body.modulate = Color(0.6,0.9,1.0)
