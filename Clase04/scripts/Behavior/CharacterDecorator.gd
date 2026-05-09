class_name CharacterDecorator
extends Node

var character:Character

func _init(_character:Character)->void:
	character = _character
func get_character()->Character:
	return character
class SpeedDecorator extends CharacterDecorator:
	var speed_bonus :float = 0.0
	var duration    :float = 5.0
	var elapsed     :float = 0.0
	
	func _init(_character:Character,multiplier:float =1.5,_duration:float = 5.0):
		super._init(_character)
		speed_bonus = character.speed * (multiplier - 1.0)
		character.speed += speed_bonus
		duration = _duration
		if character.modulate:
			character.modulate = Color(0.8,0.8,1.0)
	
	func update(delta:float)->void:
		#print('update')
		elapsed += delta
		if elapsed >= duration:
			_remove()
			
	func _remove()->void:
		if character:
			character.speed -= speed_bonus
			character.modulate = Color(1,1,1)
			queue_free()

class PoisonDecorator extends CharacterDecorator:
	var damage_per_tick :int = 5
	var tick_interval: float = 1.0
	var duration: float = 5.0
	var timer : float = 0.0
	var elapsed: float = 0.0
	
	func _init(_character:Character,dmg:int=5,_duration:float = 5.0)->void:
		super._init(_character)
		duration = _duration
		damage_per_tick = dmg
		if character.modulate:
			character.modulate = Color(0.5,1.0,0.5)
			
	func update(delta:float)->void:
		#print('update')
		timer += delta
		elapsed +=delta
		if timer > tick_interval:
			timer = 0.0
			character.take_damage(damage_per_tick)
		if elapsed >= duration:
			_remove()
			
	func _remove()->void:
		if character:
			character.modulate = Color(1,1,1)
			queue_free()

class FireDecorator extends  CharacterDecorator:
	var burn_damage : int = 8
	var duration    :float = 4.0
	var timer	    :float = 0.0
	var elapsed     :float = 0.0
	var damage_bonus : int = 0
	
	func _init(_character:Character,duration:float = 4.0)->void:
		super._init(_character)
		damage_bonus = int(character.damanage * 0.5)
		character.damanage +=damage_bonus
		if character.modulate:
			character.modulate = Color(1.0,0.5,1.0)
			
	func update(delta:float)->void:
		if not character or not character.is_alive:
			return
		timer +=delta
		elapsed += delta
		if timer >= 0.5:
			timer = 0.0
			character.take_damage(burn_damage)
		if elapsed >=duration:
			_remove()
	
	func _remove()->void:
		if character:
			character.damanage -= damage_bonus
			character.modulate = Color(1,1,1)
			queue_free()
