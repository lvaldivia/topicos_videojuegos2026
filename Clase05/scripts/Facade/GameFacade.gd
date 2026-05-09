class_name GameFacade
extends Node

var _parent:Node
var _player:Player = null
var _enemies :Array[Enemy] = []
var _spawn_pts   : Array[Vector2] = [
	Vector2(50,  50),   Vector2(590, 50),
	Vector2(50,  330),  Vector2(590, 330),
	Vector2(320, 30),   Vector2(320, 340),
	Vector2(30,  190),  Vector2(610, 190),
]
signal  wave_completed(wave:int)
signal player_died()

func setup(parent:Node)->void:
	_parent = parent
	GameManager.reset()
	print('[Facade] Game init')
	
func spawn_player(pos:Vector2 = Vector2(320,190))->Player:
	_player = load("res://scenes/characters/Player.tscn").instantiate()
	_parent.add_child(_player)
	_player.global_position = pos
	_player.player_died.connect(_on_player_died_internal)
	print('[Facade] Player spawn')
	return _player
	
func _on_player_died_internal()->void:
	player_died.emit()
	
func start_wave(wave:int) ->void:
	_enemies.clear()
	GameManager.current_wave = wave
	GameManager.enemies_alive = 0
	var new_enemies = EnemyFactory.create_wave(wave,_spawn_pts)
	for e in new_enemies:
		_add_enemy(e)
	if wave >= 1:
		_spawn_elite_enemy()
		
func _spawn_elite_enemy()->void:
	var elite = EnemyBuilder.new() \
			.from_boss() \
			.set_position(_spawn_pts[randi() % _spawn_pts.size()]) \
			.add_ability("tank").build()
	_add_enemy(elite)

func _add_enemy(e:Enemy)->void:
	if not e: return
	_parent.add_child(e)
	e.global_position = e.position
	e.enemiy_died.connect(_on_enemy_died)
	_enemies.append(e)
	GameManager.enemies_alive +=1
	
func _on_enemy_died(who:Enemy)->void:
	_enemies.erase(who)
	if _enemies.is_empty() and not GameManager.is_game_over:
		wave_completed.emit(GameManager.current_wave)

func get_status()->Dictionary:
	return {
		"wave" : GameManager.current_wave,
		"score" : GameManager.score,
		"enemies" : _enemies.size(),
		"hp" : _player.current_health if _player and is_instance_valid(_player) else 0 ,
		"bullet" : BulletFactory.BulletType.keys()[_player.current_bullet] if _player else "?"
	}
