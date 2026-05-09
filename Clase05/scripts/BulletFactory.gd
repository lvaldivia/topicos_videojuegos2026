class_name BulletFactory
extends Node

enum BulletType {NORMAL,FIRE,POISON,ICE}

const SCENES: Dictionary = {
	BulletType.NORMAL : preload("res://scenes/bullets/NormalBullet.tscn"),
	BulletType.FIRE : preload("res://scenes/bullets/FireBullet.tscn"),
	BulletType.ICE : preload("res://scenes/bullets/IceBullet.tscn"),
	BulletType.POISON : preload("res://scenes/bullets/PoisonBullet.tscn")
}

static func create(type:BulletType,pos:Vector2, dir:Vector2)->Bullet:
	if not SCENES.has(type):
		push_error("[Bullet Factory] Tipo desconocido "+str(type))
		return null
	var bullet:Bullet = SCENES[type].instantiate()
	bullet.position = pos
	bullet.direction = dir.normalized()
	print("[Factory] Bullet created :",BulletType.keys()[type])
	return bullet
