class_name DefensiveStrategy
extends AIStrategy

var _timer:float = 0.0

func execute(_entity: BaseEntity, _delta: float) -> void:
	var fighter  = _entity as PlayerFighter
	var oponent = fighter.oponent
	if not oponent or not is_instance_valid(oponent): return
	var diff = oponent.global_position.x - fighter.global_position.x
	var dist = abs(diff)
	_timer -= _delta
	if dist < 70.0:
		fighter.ai_input.move = 0.0
		fighter.ai_input.block = true
		if _timer <= 0.0:
			_timer = 0.9
			fighter.ai_input.block = false
			fighter.ai_input.light = true
		
func get_name() -> String:
	return "DEFENSIVE"
		
