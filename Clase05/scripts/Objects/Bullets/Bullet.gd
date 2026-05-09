class_name Bullet
extends Area2D

@export var speed : float = 400.0
@export var damage: int = 10
@export var color: Color = Color.WHITE

@onready var visual :ColorRect = $Visual
@onready var shape: CollisionShape2D = $CollisionShape2D

var direction : Vector2 = Vector2.UP

func _ready()->void:
	if visual:
		visual.color = color
	body_entered.connect(_on_body_entered)
	await get_tree().create_timer(3.0).timeout
	if is_inside_tree():
		queue_free()
		
func _process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body:Node)->void:
	if body.is_in_group("enemies"):
		#take_damage es una funcion de enemy cuando se haya creado
		body.take_damage(damage)
		_on_hit(body)
		queue_free()
		
func _on_hit(body:Node)->void:
	pass
	
	
