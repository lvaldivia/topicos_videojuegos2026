class_name CharacterFactory
extends Node

enum  CharacterType {
	WARRIOR,MAGE,GOBLIN,TROLL,BOSS
}

const SCENES:Dictionary = {
	CharacterType.WARRIOR : preload("res://scenes/characters/Warrior.tscn"),
	CharacterType.MAGE : preload("res://scenes/characters/Mage.tscn"),
	CharacterType.GOBLIN : preload("res://scenes/characters/Goblin.tscn"),
	CharacterType.TROLL : preload("res://scenes/characters/Troll.tscn"),
	CharacterType.BOSS : preload("res://scenes/characters/Boss.tscn")
}

static func create(type:CharacterType,pos:Vector2,level:int = 1) ->Character:
	if not SCENES.has(type):
		push_error("Tipo desconocido "+str(type))
		return null
	var character:Character = SCENES[type].instantiate()
	apply_level_scaling(character,level)
	character.position = pos
	return character
	
static func apply_level_scaling(c:Character,level:int) ->void:
	var m = 1.0 + (level - 1) * 0.15
	c.max_health = int(c.max_health * m)
	c.damanage = int(c.damanage * m)
	
static func create_wave(wave:int,positions:Array[Vector2])->Array[Character]:
	var enemies: Array[Character] = []
	var comp = get_wave_composition(wave)
	for i in comp.size():
		var e = create(comp[i],positions[i%positions.size()],wave)
		enemies.append(e)
	return enemies
	
static func get_wave_composition(wave:int)->Array[CharacterType]:
	match  wave:
		1:
			return [CharacterType.GOBLIN,CharacterType.GOBLIN]
		2:
			return [CharacterType.GOBLIN,CharacterType.TROLL]
		3:
			return [CharacterType.GOBLIN,CharacterType.TROLL,CharacterType.GOBLIN]
		_:
			var comp:Array[CharacterType] = []
			for i in wave:
				comp.append(CharacterType.GOBLIN)
			comp.append(CharacterType.BOSS)
			return comp
	

	
