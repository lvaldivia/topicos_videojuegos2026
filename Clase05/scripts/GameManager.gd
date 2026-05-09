#PATRON SINGLETON 
#SOLO UNA INSTANCIA
extends Node

var score :int  = 0
var current_wave : int = 1
var is_game_over : bool = false
var enemies_alive :int = 0

signal score_changed(nuevo:int)
signal wave_changed(wave:int)
signal game_over_triggered()

func add_score(pts:int)->void:
	score+= pts
	score_changed.emit(score)
	print("[Singleton] Score: ",score)
	
func next_wave()->void:
	current_wave +=1
	wave_changed.emit(current_wave)
	print("[Singleton] Wave: ",current_wave)
	
func trigger_game_over()->void:
	is_game_over = false
	game_over_triggered.emit()
	print("[Singleton] Game Over ",score)
	
func reset()->void:
	score = 0
	current_wave = 1
	is_game_over = false
	enemies_alive = 0
