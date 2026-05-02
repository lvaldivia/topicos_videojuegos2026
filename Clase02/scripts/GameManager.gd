class_name GameManager
extends Node2D


var player: Character = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('HOLA')
	var player_type = CharacterFactory.CharacterType.WARRIOR
	player = CharacterFactory.create(player_type,Vector2(320,400),1)
	
	add_child(player)
	player.global_position = Vector2(320, 400) 
	print(player.global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
