extends CanvasLayer

@onready var hp_label: Label = $HPLabel
@onready var score_label:Label = $ScoraLabel
@onready var state_label:Label = $StateLabel
@onready var strategy_label: Label = $StrategyLabel



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func on_hp_changed(current:int,max_hp:int)->void:
	hp_label.text = "HP: %d / %d " % [current,max_hp]

func on_state_changed(state_name:String)->void:
	state_label.text = "Estado: %s" % [state_name]

func on_score_changed(nuevo:int)->void:
	score_label.text = "Score: %s" % [nuevo]

func set_strategy(name:String)->void:
	strategy_label.text = "IA Enemigo: %s"  % [name]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
