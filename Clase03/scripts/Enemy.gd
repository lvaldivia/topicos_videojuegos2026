class_name Enemy
extends  Character

var attack_range:float = 60.0
var attack_cooldown:float = 1.5
var attack_tiemr:float = 0.0

func move(delta:float)->void:
	attack_tiemr -=delta
	var player = find_player("warriors")
	if player == null:
		velocity = Vector2.ZERO
		return
	var dist = global_position.distance_to(player.global_position)
	var dir = (player.global_position - global_position).normalized()
	if dist > attack_range:
		velocity = dir * speed
	else :
		velocity = Vector2.ZERO
		
	if dir.x != 0:
		sprite.flip_h = dir.x < 0
	move_and_slide()
	
	
func find_player(groupName:String)->Character:
	var players = get_tree().get_nodes_in_group(groupName)
	if players.size() > 0:
		return players[0] as Character
	return null
