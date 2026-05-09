class_name GameFacade
extends Node
var scene_tree :SceneTree
var parent_node : Node
var enemies : Array[Character] = []
var player :Character
var decorators: Array = []
var spawn_points: Array[Vector2] = [
	Vector2(80,  80),
	Vector2(560, 80),
	Vector2(80,  280),
	Vector2(560, 280),
	Vector2(320, 60),
	Vector2(320, 300),
	Vector2(80,  180),
	Vector2(560, 180),
]

func setup(_parent:Node, _tree:SceneTree)->void:
	parent_node = _parent
	scene_tree = _tree

func start_game()->void:
	pass
	#llamar a un reset

func spawn_player(pos:Vector2 = Vector2(320,180))->Character:
	var player_type = GameConfig.CharacterType.WARRIOR
	player = CharacterFactory.create(player_type, Vector2(320, 180), 1)
	if player == null:
		push_error("ERROR: No se pudo crear al jugador")
		return
	parent_node.add_child(player)
	player.global_position = pos
	return player

func spawn_enemy(type:GameConfig.CharacterType,level:int = 1)->Character:
	var pos = _get_best_spawn_point()
	var enemy = CharacterFactory.create(type,pos,level)
	return enemy

func _get_best_spawn_point()->Vector2:
	if not player:
		return spawn_points[randi() % spawn_points.size()]
	var mejor = spawn_points[0]
	var max_d = 0.0
	for p in spawn_points:
		var d = p.distance_to(player.global_position)
		if d > max_d:
			max_d = d
			mejor = p
	return mejor

func _add_enemy(enemy:Character)->void:
	parent_node.add_child(enemy)
	enemy.global_position = enemy.position
	enemies.append(enemy)

func clear_enemies()->void:
	for enemy in enemies:
		enemy.queue_free()
	enemies.clear()

func start_wave(wave:int)->void:
	var positions = _get_spawn_positions(wave)
	var new_enemies = CharacterFactory.create_wave(wave,positions)
	for enemy in new_enemies:
		_add_enemy(enemy)

func _get_spawn_positions(wave:int):
	var positions: Array[Vector2] = []
	for i in min(wave+1,spawn_points.size()):
		positions.append(spawn_points[i])
	return positions

func apply_effect(character:Character,effect:String,duration:float = 5.0)->void:
	match effect:
		"poison":
			var d = CharacterDecorator.PoisonDecorator.new(character,5,duration)
			parent_node.add_child(d)
			decorators.append(d)
		"fire":
			var d = CharacterDecorator.FireDecorator.new(character,duration)
			parent_node.add_child(d)
			decorators.append(d)
		"speed":
			var d = CharacterDecorator.PoisonDecorator.new(character,5,duration)
			parent_node.add_child(d)
			decorators.append(d)
		_:
			push_warning("Facade efecto desconocido ",effect)


func _process(delta: float) -> void:
	pass
	#for d in decorators:
		#d.update(delta)
