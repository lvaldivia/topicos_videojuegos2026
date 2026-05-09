class_name EnemyAdapter
extends RefCounted

var character:Enemy
func _init(_character:Enemy)->void:
	character = _character
	
func move_to(target:Vector2,detal:float)->void:
	pass
	
func attack(target:Enemy)->void:
	if not character or not character.is_alive:
		return
	target.take_damage(character.damanage)
	print("[Adapter] attack")

func get_max_hp()->int:
	if not character:
		return 0
	return character.max_health
	
func get_hp()->int:
	if not character:
		return 0
	return character.currenth_health
	
func get_pos()->Vector2:
	if not character:
		return Vector2.ZERO
	return character.global_position
	
func set_pos(x:float,y:float)->void:
	if not character:
		return
	character.global_position = Vector2(x,y)
	
func receive_damage(amount:int)->void:
	if not character:
		return
	character.take_damage(amount)

func get_name()->String:
	if not character:
		return ""
	return character.character_name
	
func is_dead()->bool:
	if not character:
		return true
	return character.is_alive
	

	
	
	
	
