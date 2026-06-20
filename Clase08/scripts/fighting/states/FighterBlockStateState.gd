class_name  FighterBlockStateState
extends FighterState

func enter()->void:
	super.enter()
	fighter.velocity = Vector2.ZERO
	fighter.is_blocking = true
	state = "BLOCK"
	animation = "block"
	play_anim()
	
func exit()->void:
	fighter.is_blocking = false
	
func get_next() -> EntityState:
	var inp = fighter.get_input()
	if not inp.block:
		return _to(FighterIdleScene.new())
	return null
	
func update(_delta: float) -> void:
	fighter.apply_gravity(_delta)
	fighter.move_and_slide()
