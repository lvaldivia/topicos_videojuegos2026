class_name Food
extends EntityWithStrategy

@export var points : int = 10
@export var grow_amount : int = 1

signal eaten(food:Food)
func _setup() -> void:
	max_health = 1
	add_to_group('food')
	
func eat()->void:
	eaten.emit(self)
	queue_free()
