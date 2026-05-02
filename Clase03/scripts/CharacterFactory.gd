class_name CharacterFactory
extends Node

static func create(type:GameConfig.CharacterType,pos:Vector2,level:int = 1) ->Character:
	if not GameConfig.SCENES.has(type):
		push_error("Tipo desconocido "+str(type))
		return null
	var character:Character = GameConfig.SCENES[type].instantiate()
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
	
static func get_wave_composition(wave:int)->Array[GameConfig.CharacterType]:
	match  wave:
		1:
			return [GameConfig.CharacterType.GOBLIN,GameConfig.CharacterType.GOBLIN]
		2:
			return [GameConfig.CharacterType.GOBLIN,GameConfig.CharacterType.TROLL]
		3:
			return [GameConfig.CharacterType.GOBLIN,GameConfig.CharacterType.TROLL,GameConfig.CharacterType.GOBLIN]
		_:
			var comp:Array[GameConfig.CharacterType] = []
			for i in wave:
				comp.append(GameConfig.CharacterType.GOBLIN)
			comp.append(GameConfig.CharacterType.BOSS)
			return comp
	

	
