class_name FighterLightAttackState
extends FighterState

var _timer: float = 0.0
var _duration: float = 0.35
var _hit_applied : bool = false
var _range:float = 65.0
var _damage:int = 0
var _timer_check: float = 0.0

func enter()->void:
	super.enter()
	fighter.velocity = Vector2.ZERO
	_timer = 0.0
	_damage = fighter.light_damage
	_timer_check = _duration * 0.4
	_hit_applied = false
	animation = "light_attack"
	state = "LIGHT_ATTACK"
	play_anim()

func update(_delta: float) -> void:
	fighter.apply_gravity(_delta)
	fighter.move_and_slide()
	_timer+= _delta
	if(_timer >= _timer_check and not _hit_applied):
		_hit_applied = true
		_try_hit(fighter)
		
func _try_hit(fighter:PlayerFighter)->void:
	var op = fighter.oponent
	if op and is_instance_valid(op):
		var dist = abs(op.global_position.x - fighter.global_position.x)
		if dist < _range:
			fighter.do_hit(op,_damage)
			

func get_next() -> EntityState:
	if _timer >= _duration:
		return _to(FighterIdleScene.new())
	return null
			
