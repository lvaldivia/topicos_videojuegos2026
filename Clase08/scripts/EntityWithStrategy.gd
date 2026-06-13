class_name EntityWithStrategy
extends BaseEntity

var ai_strategy : AIStrategy = null
signal strategy_changed(name: String)

func _process(delta: float) -> void:
	if not is_alive or ai_strategy == null: return
	ai_strategy.execute(self, delta)

func set_strategy(strategy: AIStrategy) -> void:
	ai_strategy = strategy
	strategy_changed.emit(strategy.get_name())
