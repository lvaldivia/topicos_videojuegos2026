class_name EntityWithState
extends BaseEntity

var current_state : EntityState = null
signal state_changed(state_name: String)

func _process(delta: float) -> void:
	if not is_alive or current_state == null: return
	current_state.update(delta)
	var next = current_state.get_next()
	if next != null: _change_state(next)

func _change_state(new_state: EntityState) -> void:
	if current_state != null: current_state.exit()
	current_state            = new_state
	current_state.owner_node = self
	current_state.enter()
	state_changed.emit(new_state.get_name())
