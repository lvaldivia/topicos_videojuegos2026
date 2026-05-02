class_name GameManager
extends Node2D

var player: Character = null
var enemies:Array[Character] = []
var spawn_points: Array[Vector2] = [
	# Esquinas interiores
	Vector2(80,  80),
	Vector2(560, 80),
	Vector2(80,  280),
	Vector2(560, 280),
	Vector2(320, 60),
	Vector2(320, 300),
	Vector2(80,  180),
	Vector2(560, 180),
]

func _ready() -> void:
	print('=== GameManager listo ===')
	print("current wave de GameConfig Singleton ",GameConfig.current_wave)
	#ESTO ES CON FACTORY
	#spawn_player("factory")
	#spawn_enemy("factory")
	#ESTO ES CON BUILDER
	spawn_player("builder")
	spawn_enemy("builder")
	
	
func spawn_player(type:String):
	if type == "factory":
		var player_type = GameConfig.CharacterType.WARRIOR
		player = CharacterFactory.create(player_type, Vector2(320, 180), 1)
		if player == null:
			push_error("ERROR: No se pudo crear al jugador")
			return
		add_child(player)
		player.global_position = Vector2(320, 180)
		print("Jugador en posición en Factory:", player.global_position)
	elif type == "builder":
		player = CharacterBuilder.new().from_warrior().set_name("Player").build()
		add_child(player)
		player.global_position = Vector2(320, 180)
		print("Jugador en posición en Builder:", player.global_position)
	
func spawn_enemy(type:String):
	if type == "factory":
		var ene = CharacterFactory.create_wave(3,spawn_points);
		for e in ene:
			add_child(e)
			e.global_position = e.position
			enemies.append(e)
	elif type == "builder":
		var enemy = null
		for e in spawn_points:
			enemy = CharacterBuilder.new().from_goblin().set_position(e).build()
			add_child(enemy)
			enemy.global_position = e
			enemies.append(e)
	if(enemies.size()  == 0):
		var enemy = null
		for e in enemies:
			enemy = CharacterPrototype.clone(e,e.position)
			add_child(enemy)
			enemy.global_position = e.position
			enemies.append(e)
	
func _process(delta: float) -> void:
	pass
	
	
	
