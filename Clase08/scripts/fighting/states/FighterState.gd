class_name FighterState
extends EntityState

var fighter:PlayerFighter
var state:String = ""
var animation:String =""

func enter()->void:
	fighter = owner_node as PlayerFighter
		
func play_anim():
	if fighter.anim and animation != "":
		fighter.anim.play(animation)

func get_name()->String:
	return state
	
func _to(s:EntityState)->EntityState:
	s.owner_node = owner_node
	return s
