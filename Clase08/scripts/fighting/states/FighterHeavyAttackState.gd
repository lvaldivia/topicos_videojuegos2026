class_name FighterHeavyAttackState
extends FighterLightAttackState

func enter()->void:
	super.enter()
	animation = "heavy_attack"
	state = "HEAVY_ATTACK"
	_damage = fighter.heavy_damage
	_timer_check = _duration * 0.5
