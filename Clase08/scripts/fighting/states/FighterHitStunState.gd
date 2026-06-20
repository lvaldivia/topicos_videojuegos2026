class_name FighterHitStunState
extends EntityState

var _timer:float = 0.0
var _duration:float = 0.35

func enter()               -> void:
	var f = owner_node as PlayerFighter
	_timer = 0.0
	f.velocity.x = -f.facing * 60.0
	if f.anim:
		f.anim.play("hurt")
