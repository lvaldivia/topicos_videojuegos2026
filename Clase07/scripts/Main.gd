# Main.gd — Plantilla base
# Conecta Observer, gestiona Strategy y usa Facade.
extends Node2D

var facade : GameFacade = GameFacade.new()

func _ready() -> void:
	add_child(facade)
	facade.setup(self)

	# OBSERVER — conectar senales aqui
	# entity.health_changed.connect(hud.on_hp_changed)
	# GameManager.score_changed.connect(hud.on_score_changed)
	# facade.all_entities_dead.connect(_on_all_dead)

	# FACTORY — crear entidades
	# var player = facade.spawn_entity(PlayerScene, Vector2(320, 180))

	# BUILDER — crear entidad configurada
	# var boss = facade.spawn_configured(EnemyScene, pos, 500, 80.0, Color.RED)

	# PROTOTYPE — clonar entidad existente
	# var clon = EntityPrototype.clone(player, Vector2(100, 100))

func _input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed): return
	match event.keycode:
		# STRATEGY — cambiar estrategia con tecla
		# KEY_TAB:
		#     enemy.set_strategy(ChaseStrategy.new())
		pass

func _on_all_dead() -> void:
	GameManager.next_level()
