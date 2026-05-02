# Clase 02 — Herencia, Polimorfismo y Factory Method
**Tópicos en Videojuegos — UPC**

---

## ¿Qué se ve en esta clase?

Introducción a los **Patrones de Creación** aplicados a videojuegos. Se construye un sistema de personajes usando herencia, polimorfismo y el patrón **Factory Method**.

---

## Conceptos aprendidos

### Programación Orientada a Objetos
- **Herencia** — `Warrior extends Character`
- **Polimorfismo** — `_setup()` y `move()` se comportan distinto en cada subclase
- **`class_name`** — registrar una clase globalmente en Godot
- **`@export`** — propiedades visibles en el Inspector
- **`@onready`** — cargar nodos hijos cuando el nodo entra al árbol
- **Señales** — `health_changed`, `character_died`

### Patrón de Diseño
- **Factory Method** — `CharacterFactory.create()` centraliza la creación de personajes

---

## Estructura del proyecto

```
Clase02/
├── assets/sprites/Warrior/   ← Spritesheets del Warrior (idle, walk, attack, death)
├── scenes/
│   ├── Main.tscn             ← Escena principal
│   └── characters/
│       ├── Warrior.tscn
│       ├── Goblin.tscn
│       ├── Mage.tscn
│       ├── Troll.tscn
│       └── Boss.tscn
├── scripts/
│   ├── character.gd          ← Clase base (herencia)
│   ├── warrior.gd            ← Subclase del jugador
│   ├── CharacterFactory.gd   ← Patrón Factory Method
│   └── GameManager.gd        ← Singleton (Autoload)
└── project.godot
```

---

## Jerarquía de clases

```
CharacterBody2D
    └── Character              ← clase base (character.gd)
            └── Warrior        ← jugador (warrior.gd)
```

---

## Patrón Factory Method

```gdscript
# Sin Factory — acoplado:
var w = WarriorScene.instantiate()
w.max_health = int(w.max_health * nivel)

# Con Factory — desacoplado:
var w = CharacterFactory.create(CharacterType.WARRIOR, pos, nivel)
```

**`CharacterFactory.gd`** tiene:
- `enum CharacterType` — lista de tipos disponibles
- `SCENES` — diccionario tipo → escena precargada
- `create(type, pos, level)` — crea y escala el personaje
- `create_wave(wave, positions)` — crea una oleada completa
- `get_wave_composition(wave)` — define qué enemigos van en cada oleada

---

## Controles

| Tecla | Acción |
|-------|--------|
| ← → ↑ ↓ / WASD | Mover al Warrior |

---

## Cómo abrir

1. Abrir Godot 4.x
2. **Import** → seleccionar `project.godot`
3. Presionar **F5** para jugar
