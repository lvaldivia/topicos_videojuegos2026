extends Node

# Compatibilidad con GameFacade
var score         : int  = 0
var current_level : int  = 1
var is_game_over  : bool = false

# Estado de la pelea
var round_number : int   = 1
var round_time   : float = 60.0
var player_wins  : int   = 0
var cpu_wins     : int   = 0
var winner_name  : String = ""

signal score_changed(nuevo: int)
signal level_changed(level: int)
signal game_over_triggered()
signal round_started(n: int)
signal round_time_changed(t: int)
signal round_ended(winner: String)
signal wins_changed(player_wins: int, cpu_wins: int)

func add_score(pts: int) -> void:
	score += pts
	score_changed.emit(score)

func next_level() -> void:
	current_level += 1
	level_changed.emit(current_level)

func trigger_game_over() -> void:
	is_game_over = true
	game_over_triggered.emit()

func reset() -> void:
	score = 0
	current_level = 1
	is_game_over = false
	round_number = 1
	player_wins = 0
	cpu_wins = 0
	winner_name = ""

func start_round(time_limit: float = 60.0) -> void:
	round_time = time_limit
	is_game_over = false
	round_started.emit(round_number)
	round_time_changed.emit(int(ceil(round_time)))

func tick_round(delta: float) -> bool:
	if is_game_over:
		return false
	round_time -= delta
	round_time_changed.emit(int(ceil(max(round_time, 0.0))))
	if round_time <= 0.0:
		round_time = 0.0
		return true
	return false

func end_round(winner: String) -> void:
	winner_name = winner
	if winner == "player" or winner == "time_player":
		player_wins += 1
	elif winner == "cpu" or winner == "time_cpu":
		cpu_wins += 1
	wins_changed.emit(player_wins, cpu_wins)
	is_game_over = true
	round_ended.emit(winner)

func next_round() -> void:
	round_number += 1
