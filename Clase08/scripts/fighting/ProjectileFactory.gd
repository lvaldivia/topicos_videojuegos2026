class_name ProjectileFactory
extends EntityFactory

const PROJECTILE_SCENE : PackedScene = preload("res://scenes/fighting/Projectile.tscn")

static func create_projectile(pos:Vector2, direction:int,owner_figther:PlayerFighter)->Projectile:
	var p:Projectile = PROJECTILE_SCENE.instantiate()
	p.position = pos
	p.direction = direction
	p.owner_fighter = owner_figther
	return p
