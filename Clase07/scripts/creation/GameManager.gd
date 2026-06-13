# SINGLETON — GameManager.gd
# Autoload: Project > Project Settings > Autoload > GameManager
# Accesible desde cualquier script: GameManager.add_score(10)
extends Node

var score        : int  = 0
var current_level: int  = 1
var is_game_over : bool = false
var is_paused    : bool = false

signal score_changed(nuevo: int)
signal level_changed(level: int)
signal game_over_triggered()
signal game_paused(paused: bool)

func add_score(pts: int) -> void:
	score += pts
	score_changed.emit(score)

func next_level() -> void:
	current_level += 1
	level_changed.emit(current_level)

func trigger_game_over() -> void:
	is_game_over = true
	game_over_triggered.emit()

func toggle_pause() -> void:
	is_paused = not is_paused
	game_paused.emit(is_paused)

func reset() -> void:
	score = 0; current_level = 1
	is_game_over = false; is_paused = false
