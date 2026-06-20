class_name FighterIdleScene
extends FighterState

func enter()               -> void:
	super.enter()
	fighter.is_blocking = false
	fighter.velocity =Vector2.ZERO
	animation = "idle"
	state = "IDLE"
	play_anim()

func get_next() -> EntityState:
	var inp = fighter.get_input()
	if inp.jump:   return _to(FighterJumpState.new())
	if inp.light:  return _to(FighterLightAttackState.new())
	if inp.heavy:  return _to(FighterHeavyAttackState.new())
	if inp.block:  return _to(FighterBlockStateState.new())
	if abs(inp.move) > 0.1: return _to(FighterWalkState.new())
	return null


func update(delta:float)->void:
	fighter.apply_gravity(delta)
	fighter.move_and_slide()
	var inp = fighter.get_input()
	if inp.special and fighter.can_fire_special():
		fighter.fire_projectile()
	
