class_name NormalBullet
extends Bullet


func _ready()->void:
	speed = 400.0
	damage = 10
	color = Color.WHITE
	super._ready()
