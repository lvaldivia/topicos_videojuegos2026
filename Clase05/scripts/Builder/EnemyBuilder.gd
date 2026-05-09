class_name EnemyBuilder
extends RefCounted

const GOBLIN = preload("res://scenes/enemies/Goblin.tscn")
const TROLL = preload("res://scenes/enemies/Troll.tscn")
const BOSS = preload("res://scenes/enemies/BossEnemy.tscn")

var _scene = GOBLIN
var _hp : int = -1
var _spd: float = 1.0
var _dmg : int  = -1
var _score : int  = -1
var _pos: Vector2 = Vector2.ZERO
var _abilities:Array[String] = []

func from_goblin() ->EnemyBuilder: _scene = GOBLIN; return self
func from_troll() ->EnemyBuilder: _scene = TROLL; return self
func from_boss() ->EnemyBuilder: _scene = BOSS; return self

func set_health(hp:int) ->EnemyBuilder: _hp = hp; return self
func set_speed(spd:float) ->EnemyBuilder: _spd = spd; return self
func set_position(p:Vector2)->EnemyBuilder: _pos = p; return self

func add_ability(a:String) ->EnemyBuilder: _abilities.append(a); return self

func build() ->Enemy:
	var e:Enemy = _scene.instantiate()
	e._setup()
	if _hp != -1: e.max_health = _hp
	if _spd != -1: e.speed = _spd
	if _dmg != -1: e.damage = _dmg
	e.position = _pos
	for a in _abilities: _apply(e,a)
	return e

func _apply(e:Enemy,a:String)->void:
	match a:
		"tank": e.max_health = int(e.max_health * 1.5)
		"speedy" : e.speed *= 1.8
		"elite" : e.max_health = int(e.max_health*2.0); e.damage = int(e.damage*1.5)
