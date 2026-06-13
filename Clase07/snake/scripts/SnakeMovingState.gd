class_name SnakeMovingState
extends EntityState

func enter()               -> void:
	if owner_node.has_node("Visual"):
		owner_node.get_node("Visual").color = Color(0.2,0.85,0.2)

func update(_delta: float) -> void:
	var head = owner_node as SnakeHead
	if Input.is_action_just_pressed("ui_up") and head.direction != Vector2.DOWN :
		head.next_dir = Vector2.UP
	elif Input.is_action_just_pressed("ui_down") and head.direction != Vector2.UP:
		head.next_dir = Vector2.DOWN
	elif Input.is_action_just_pressed("ui_left") and head.direction != Vector2.LEFT:
		head.next_dir = Vector2.LEFT
	elif Input.is_action_just_pressed("ui_right") and head.direction != Vector2.RIGHT:
		head.next_dir = Vector2.RIGHT
	head._move_timer -= _delta
	if head._move_timer <=0:
		head._move_timer = head.move_speed
		head._do_move()

func get_next() -> EntityState:
	if not (owner_node as SnakeHead).is_alive:
		var s = SnakeDeadState.new()
		s.owner_node = owner_node
		return s
	return null
	
func get_name()->String: 
	return "MOVING"
	
