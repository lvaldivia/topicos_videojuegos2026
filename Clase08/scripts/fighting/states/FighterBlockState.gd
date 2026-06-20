class_name FighterBlockState
extends  FighterState

func enter()               -> void:
	super.enter()
	fighter.velocity = Vector2.ZERO
	fighter.is_blocking = true
	animation = "block"
	state = "BLOCK"
	play_anim()

func update(delta:float)->void:
	fighter.apply_gravity(delta)
	fighter.move_and_slide()
	
func exit()                -> void:
	fighter.is_blocking =false
	
func get_next() -> EntityState:
	var inp = fighter.get_input()
	if not inp.block:
		var s = FighterIdleScene.new()
		s.owner_node = fighter
		return s
	return null
