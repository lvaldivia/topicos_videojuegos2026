class_name FighterWalkState
extends  FighterState

func enter()->void:
	super.enter()
	animation = 'walk'
	state = "WALK"
	play_anim()

func update(delta:float)->void:
	var inp = fighter.get_input()
	fighter.velocity.x = inp.move * fighter.speed
	fighter.apply_gravity(delta)
	fighter.move_and_slide()
	if inp.special and fighter.can_fire_special():
		fighter.fire_projectile()
		
func get_next() -> EntityState:
	var inp = fighter.get_input()	
	if inp.jump:
		return _to(FighterJumpState.new())
	if inp.light:
		return _to(FighterLightAttackState.new())
	if inp.heavy:
		return _to(FighterHeavyAttackState.new())
	if inp.block:
		return _to(FighterBlockStateState.new())
	if abs(inp.move) < 0.1: 
		return _to(FighterIdleScene.new())
	return null
	
