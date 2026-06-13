class_name SpecialFood
extends Food


func _setup() -> void:
	super._setup()
	points = 30
	grow_amount = 2
	set_strategy(WanderStrategy.new())
	if visual:
		visual.color = Color(1.0,0.85,0.0)
