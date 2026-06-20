class_name AgressiveStrategy
extends AIStrategy

var _atk_timer:float = 0.0

func execute(_entity: BaseEntity, _delta: float) -> void:
	var fighter  = _entity as PlayerFighter
	var oponent = fighter.oponent
	if not oponent or not is_instance_valid(oponent): return
	var diff = oponent.global_position.x - fighter.global_position.x
	var dist = abs(diff)
	_atk_timer -= _delta
	if dist > 60.0:
		fighter.ai_input.move = sign(diff)
	else:
		fighter.ai_input.move = 0.0
		if _atk_timer <= 0.0:
			_atk_timer = 0.7
			if randf() < 0.6:
				fighter.ai_input.light = true
			else:
				fighter.ai_input.heavy = true
	if randf() < 0.01:
		fighter.ai_input.jump = true
		
func get_name() -> String:
	return "AGRESSIVE"
		
