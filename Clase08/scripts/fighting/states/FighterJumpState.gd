class_name FighterJumpState
extends  FighterState

func enter()->void:
	super.enter()
	animation = 'jump'
	fighter.velocity.y = fighter.jump_force
	state = "JUMP"
	play_anim()

func update(_delta: float) -> void:
	var inp = fighter.get_input()
	fighter.velocity.x = inp.move * fighter.speed
	fighter.apply_gravity(_delta)
	fighter.move_and_slide()
	
func get_next()->EntityState:
	if fighter.global_position.y >= fighter.ground_y and fighter.velocity.y >= 0.0:
		return _to(FighterIdleScene.new())
	return null
