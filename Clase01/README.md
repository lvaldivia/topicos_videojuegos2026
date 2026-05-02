# Clase 01 — Introducción a Godot 4
**Tópicos en Videojuegos — UPC**

---

## ¿Qué se ve en esta clase?

Introducción al motor Godot 4 y los conceptos básicos de movimiento de un personaje en 2D. Se trabaja con un sprite de Luigi como personaje de prueba.

---

## Conceptos aprendidos

- Crear un proyecto en Godot 4
- Nodo `CharacterBody2D` — base para personajes con físicas
- `_physics_process(delta)` — función que se ejecuta cada frame de física
- `Input.get_vector()` — leer el input del teclado/joystick
- `velocity` y `move_and_slide()` — mover al personaje con físicas
- `@export` — exponer variables al Inspector de Godot

---

## Estructura del proyecto

```
Clase01/
├── Scenes/
│   └── escena_1.tscn       ← Escena principal con el personaje
├── Scripts/
│   └── luigi_body.gd       ← Script de movimiento del personaje
├── luigui.png              ← Sprite del personaje
└── project.godot
```

---

## Código principal

**`luigi_body.gd`**
```gdscript
extends CharacterBody2D

@export var speed = 300.0   # Velocidad editable desde el Inspector

func _physics_process(delta: float) -> void:
    var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
    velocity = direction * speed
    move_and_slide()
```

---

## Controles

| Tecla | Acción |
|-------|--------|
| ← → ↑ ↓ / WASD | Mover al personaje |

---

## Cómo abrir

1. Abrir Godot 4.x
2. **Import** → seleccionar `project.godot`
3. Presionar **F5** para jugar
