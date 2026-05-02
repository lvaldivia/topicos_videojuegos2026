# Clase 03 — Patrones de Creación Avanzados
**Tópicos en Videojuegos — UPC**

---

## ¿Qué se ve en esta clase?

Se expanden los patrones de creación del proyecto anterior agregando **Builder**, **Prototype** y **Abstract Factory**, además de refactorizar con un **Singleton** de configuración (`GameConfig`).

---

## Patrones implementados

### 1. Singleton — `GameConfig.gd` (Autoload)
Centraliza la configuración global del juego: tipos de personajes, escenas y estado.

```gdscript
# Accesible desde cualquier script:
GameConfig.SCENES[GameConfig.CharacterType.GOBLIN]
GameConfig.score
GameConfig.add_score(10)
```

**Configuración en Godot:** `Project → Project Settings → Autoload → GameConfig.gd`

---

### 2. Factory Method — `CharacterFactory.gd`
Creación centralizada de personajes por tipo y nivel (igual que Clase02, mejorado).

```gdscript
var goblin = CharacterFactory.create(CharacterType.GOBLIN, pos, nivel)
var oleada = CharacterFactory.create_wave(3, spawn_points)
```

---

### 3. Builder — `CharacterBuilder.gd`
Construye personajes paso a paso con API fluida. Permite personalizar stats sin modificar las escenas.

```gdscript
var jefe = CharacterBuilder.new()
    .from_goblin()
    .set_name("Goblin Jefe")
    .set_max_health(150)
    .set_damanage(30)
    .build()
add_child(jefe)
```

**Clave:** cada método devuelve `self` para encadenar llamadas. `build()` siempre es el último.

---

### 4. Prototype — `CharacterPrototype.gd`
Clona un personaje ya existente copiando sus stats actuales.

```gdscript
# Crear prototipo
var prototipo = CharacterBuilder.new().from_goblin()
    .set_max_health(200).build()
add_child(prototipo)

# Clonar 3 copias exactas
var clon = CharacterPrototype.clone(prototipo, Vector2(300, 200))
add_child(clon)
```

**Diferencia con Factory:** Factory crea desde la escena base (stats default). Prototype copia los stats actuales del objeto vivo.

---

### 5. Abstract Factory — `AbstractCharacterFactory.gd` + `FantasyFactory.gd`
Crea familias completas de personajes. Cambiar la factory cambia todos los personajes del juego.

```gdscript
var factory = FantasyFactory.new()
var player  = factory.create_player(pos)       # Warrior
var enemigo = factory.create_week_enemy(pos)   # Goblin
var boss    = factory.create_boss_enemy(pos)   # Boss
```

---

## Estructura del proyecto

```
Clase03/
├── assets/sprites/Warrior/      ← Spritesheets
├── scenes/
│   ├── Main.tscn
│   └── characters/
│       ├── Warrior.tscn
│       ├── Goblin.tscn
│       ├── Mage.tscn
│       ├── Troll.tscn
│       └── Boss.tscn
├── scripts/
│   ├── character.gd             ← Clase base
│   ├── warrior.gd               ← Jugador
│   ├── Enemy.gd                 ← Base de enemigos (IA)
│   ├── Goblin.gd                ← Enemigo rápido
│   ├── Troll.gd                 ← Enemigo resistente
│   ├── Boss.gd                  ← Jefe con 2 fases
│   ├── GameConfig.gd            ← Singleton (Autoload)
│   ├── GameManager.gd           ← Lógica principal
│   ├── CharacterFactory.gd      ← Factory Method
│   ├── CharacterBuilder.gd      ← Builder
│   ├── CharacterPrototype.gd    ← Prototype
│   ├── AbstractCharacterFactory.gd ← Abstract Factory (base)
│   └── FantasyFactory.gd        ← Abstract Factory (familia)
└── project.godot
```

---

## Jerarquía de clases

```
CharacterBody2D
    └── Character
            ├── Warrior          ← jugador (WASD)
            └── Enemy            ← base IA (perseguir y atacar)
                    ├── Goblin   ← rápido, débil
                    ├── Troll    ← lento, resistente
                    └── Boss     ← fase 1 y fase 2
```

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
