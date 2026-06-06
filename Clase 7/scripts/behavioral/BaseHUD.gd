# OBSERVER (suscriptor) — BaseHUD.gd
# Conectar en Main.gd con .connect()
# Sobreescribir para agregar mas labels.
class_name BaseHUD
extends CanvasLayer

@onready var score_label : Label = $ScoreLabel
@onready var level_label : Label = $LevelLabel
@onready var hp_label    : Label = $HPLabel

func _ready() -> void:
	GameManager.score_changed.connect(on_score_changed)
	GameManager.level_changed.connect(on_level_changed)
	GameManager.game_over_triggered.connect(on_game_over)

func on_hp_changed(current: int, max_hp: int) -> void:
	if hp_label: hp_label.text = "HP: %d / %d" % [current, max_hp]

func on_score_changed(nuevo: int) -> void:
	if score_label: score_label.text = "Score: " + str(nuevo)

func on_level_changed(level: int) -> void:
	if level_label: level_label.text = "Nivel: " + str(level)

func on_game_over() -> void:
	pass  # sobreescribir para mostrar pantalla de game over
