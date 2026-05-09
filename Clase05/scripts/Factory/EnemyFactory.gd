class_name EnemyFactory
extends Node

enum EnemyType {GOBLIN,TROLL, BOSS}

const SCENES:Dictionary = {
	EnemyType.GOBLIN : preload("res://scenes/enemies/Goblin.tscn"),
	EnemyType.TROLL : preload("res://scenes/enemies/Troll.tscn"),
	EnemyType.BOSS : preload("res://scenes/enemies/BossEnemy.tscn")
}

static  func create(type:EnemyType,pos:Vector2)->Enemy:
	if not SCENES.has(type):
		push_error("[EnemyFactory] type unknown :"+str(type))
		return null
	var enemy:Enemy = SCENES[type].instantiate()
	enemy.position = pos
	print("[EnemyFactory] Enemy created ",EnemyType.keys()[type])
	return enemy
	
static func create_wave(wave:int,position:Array[Vector2])->Array[Enemy]:
	var enemies:Array[Enemy] = []
	var comp:Array[EnemyType] = _get_composition(wave)
	for i in comp.size():
		var e = create(comp[i],position[i%position.size()])
		if e: enemies.append(e)
	return enemies

static func _get_composition(wave:int)->Array[EnemyType]:
	match wave:
		1: return [EnemyType.GOBLIN,EnemyType.GOBLIN,EnemyType.GOBLIN]
		2: return [EnemyType.GOBLIN,EnemyType.GOBLIN,EnemyType.TROLL]
		3: return [EnemyType.GOBLIN,EnemyType.TROLL,EnemyType.GOBLIN,EnemyType.TROLL]
		_:
			var comp:Array[EnemyType] = []
			for i in wave + 1: comp.append(EnemyType.GOBLIN)
			comp.append(EnemyType.TROLL)
			comp.append(EnemyType.BOSS)
			return comp
	
