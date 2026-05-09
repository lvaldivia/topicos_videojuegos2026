extends Node


var facade:GameFacade = GameFacade.new()
var _wave_timer : float = 0.0
var _wave_delay : float = 3.0

@onready var ui_score:Label = $UI/ScoreLabel
@onready var ui_wave:Label = $UI/WaveLabel
@onready var ui_hp:Label = $UI/HPLabel
@onready var ui_bullet:Label = $UI/BulletLabel
@onready var ui_gameoiver:Label = $UI/GameOverLabel

func _ready() -> void:
	add_child(facade)
	facade.setup(self)
	var player: Player = facade.spawn_player()
	facade.wave_completed.connect(_on_wave_completed)
	facade.player_died.connect(_on_played_died)
	await get_tree().create_timer(0.5).timeout
	facade.start_wave(1)


func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	var status:Dictionary = facade.get_status()
	ui_score.text = "Score :" + str(status.score)
	ui_wave.text = "Wave :" + str(status.wave)
	ui_hp.text = "HP :"  + str(status.hp)
	ui_bullet.text = "Bullet "+str(status.bullet)
	

func _on_wave_completed(wave:int)->void:
	ui_wave.text = "Wave "+str(wave)+ " completed!"
	await get_tree().create_timer(_wave_delay).timeout
	if not GameManager.is_game_over:
		facade.start_wave(wave + 1)
		ui_wave.text = "Wave "+str(wave+1)

func _on_played_died()->void:
	ui_gameoiver.text = "GAME OVER \n SCORE: " +str(GameManager.score)
	ui_gameoiver.visible = true
	GameManager.is_game_over = true
