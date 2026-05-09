class_name FireBullet
extends Bullet

func _ready()->void:
	speed = 350.0
	damage = 15
	color = Color(1.0,0.4,0.0)
	super._ready()
	
func _on_hit(body:Node)->void:
	#solo valida con enemigos y metodos apply burn
	if body.has_method("apply_burn"):
		#en enemigos crar apply_burn
		body.apply_burn(5,3.0)
	body.modulate = Color(1.0,0.5,0.1)
	
