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

var score:int = 0
var current_wave: int = 1
var is_game_over : bool = false

func add_score(puntos:int)->void:
	score+=puntos
