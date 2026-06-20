class_name FighterKOState
extends FighterState

func enter()->void:
	super.enter()
	fighter.velocity = Vector2.ZERO
	animation = "ko"
	state = "KO"
	play_anim()
		
func update(delta:float)->void:
	fighter.apply_gravity(delta)
	fighter.move_and_slide()
	
