class_name NormalFood
extends Food


func _setup() -> void:
	super._setup()
	points = 10
	grow_amount = 1
	if visual:
		visual.color = Color(0.9,0.2,0.2)
