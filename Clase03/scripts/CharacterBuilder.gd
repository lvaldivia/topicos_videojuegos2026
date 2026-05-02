class_name CharacterBuilder
extends RefCounted
var scene = GameConfig.SCENES[GameConfig.CharacterType.WARRIOR]
var character_name : String = ""
var max_health : int = -1
var speed : float = -1.0
var damanage : int = -1
var position:Vector2 = Vector2.ZERO

func set_position(_position:Vector2) ->CharacterBuilder:
	position = _position
	return self

func set_name(_character_name:String) ->CharacterBuilder:
	character_name = _character_name;
	return self
	
func set_max_health(_max_health:int) ->CharacterBuilder:
	max_health = _max_health;
	return self
	
func set_max_speed(_speed:float) ->CharacterBuilder:
	speed = _speed
	return self
	
func set_damanage(_damanage:float) ->CharacterBuilder:
	damanage = _damanage
	return self

func from_warrior() ->CharacterBuilder:
	scene = GameConfig.SCENES[GameConfig.CharacterType.WARRIOR]
	return self
	
func from_mage() ->CharacterBuilder:
	scene = GameConfig.SCENES[GameConfig.CharacterType.MAGE]
	return self

func from_goblin() ->CharacterBuilder:
	scene = GameConfig.SCENES[GameConfig.CharacterType.GOBLIN]
	return self
	
func from_troll() ->CharacterBuilder:
	scene = GameConfig.SCENES[GameConfig.CharacterType.TROLL]
	return self
	
func from_boss() ->CharacterBuilder:
	scene = GameConfig.SCENES[GameConfig.CharacterType.BOSS]
	return self

func build() ->Character:
	var c:Character= scene.instantiate()
	c._setup()
	if(character_name != ""): c.character_name = character_name
	if(max_health != -1): c.max_health = max_health
	if(damanage != -1): c.damanage = damanage
	if(speed != -1) : c.speed = speed
	print("[Builder] ", c.character_name," HP ",c.max_health," DMG ",c.damanage)
	return c
