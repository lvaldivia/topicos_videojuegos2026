class_name ZonningStrategy
extends AIStrategy

var _timer: float = 0.0

func execute(_entity: BaseEntity, _delta: float) -> void:
	var fighter  = _entity as PlayerFighter
	var oponent = fighter.oponent
	if not oponent or not is_instance_valid(oponent): return
	var diff = oponent.global_position.x - fighter.global_position.x
	var dist = abs(diff)
	var ideal = 180.0
	_timer -=_delta
	if dist < ideal - 20.0:
		fighter.ai_input.move  = -sign(diff)
	elif dist > ideal + 20.0:
		fighter.ai_input.move = sign(diff)
	else :
		fighter.ai_input.move = 0.0
	if _timer <= 0.0 and dist > 90.0:
		_timer = 1.4
		fighter.ai_input.special = true
		
func get_name()->String:
	return "ZONING"
