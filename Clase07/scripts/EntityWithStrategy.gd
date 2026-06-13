# EntityWithStrategy.gd
# BaseEntity con Strategy intercambiable.
# Extiende esta clase para crear entidades con IA cambiable.
# EJEMPLO de uso:
#   class_name Enemy
#   extends EntityWithStrategy
#   func _setup():
#       add_to_group("enemies")
#       set_strategy(ChaseStrategy.new())
class_name EntityWithStrategy
extends BaseEntity

var ai_strategy : AIStrategy = null

signal strategy_changed(strategy_name: String)

func _process(delta: float) -> void:
	if not is_alive or ai_strategy == null: return
	ai_strategy.execute(self, delta)

# Llamar esto para cambiar de estrategia en runtime
func set_strategy(strategy: AIStrategy) -> void:
	ai_strategy = strategy
	strategy_changed.emit(strategy.get_name())
