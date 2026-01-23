# Folder Outline

Quick breakdown of the project structure and intended scene graph.

## Top-Level Scene Graph

```
GameRoot.tscn (Autoload-friendly root)
└── Node2D GameRoot
    ├── Node SceneRouter (script: SceneRouter.gd)
    ├── CanvasLayer UIRoot (active UI screens get instanced here)
    └── Node AudioRoot (Music/SFX players)
```

SceneRouter handles changing between Title → Menu → Level → End screens.

## Level Scene Structure

```
Level1.tscn
└── Node2D Level1 (script: LevelController.gd)
    ├── Node2D World
    │   ├── Node2D Background (ScrollController.gd)
    │   ├── TileMap or Sprite2D strips
    │   └── Node2D Actors
    │       ├── Player instance
    │       ├── Node2D Enemies
    │       ├── Node2D Projectiles
    │       └── Node2D FX
    ├── Node SpawnController (SpawnController.gd)
    └── CanvasLayer HUDLayer
        └── HUD instance
```

> Note: Put bullets under Projectiles so cleanup is easy.

## Core Scripts: Responsibilities

### GameState.gd (Singleton / Autoload)

- Holds global run state:
  - `current_level_index`
  - `player_stats` (HP default)
  - `settings` (audio volume later)
  - `transitions`

### SceneRouter.gd

- `goto_title()`
- `goto_menu()`
- `start_level(level_id)`
- `goto_gameover()`
- `goto_levelcomplete()`
- `goto_victory()`

### LevelController.gd

- Owns the level lifecycle:
  - start timer
  - register enemy counts
  - listen for player death
  - listen for “all enemies spawned and defeated”
  - triggers LevelComplete

### SpawnController.gd

- Data-driven spawns from a list/timeline:
  - `spawn_wave(wave_data)`
  - keeps `spawned_total`, `killed_total`
  - signals `all_waves_finished`

### ScrollController.gd

- constant vertical scroll speed
- background looping
- optional “halt scroll” hook for boss later

## Player & Combat Components

### Player.gd

- reads input
- moves (snap with light smoothing)
- enforces bounds
- owns Health component
- spawns bullets via PlayerWeapon

### PlayerWeapon.gd

- fire rate: 2/sec (timer-based)
- spawns `PlayerBullet.tscn` with velocity upward

### Health.gd (Reusable component for player + enemies)

- `max_hp`, `hp`
- `apply_damage(amount)`
- signals: `damaged`, `died`, `hp_changed`

### Hit/Hurt separation (simple but clean)

- Hitbox on bullets (`Area2D`)
- Hurtbox on player/enemies (`Area2D`)
- On overlap: bullet calls `apply_damage(1)` then despawns

## Enemy Architecture

### EnemyBase.gd

Shared behavior:

- Health component
- movement path / velocity
- optional weapon ref
- death FX spawn
- emits `killed` to LevelController/SpawnController

### EnemyGunner.gd

- movement: straight or slight lateral
- weapon: fixed pattern firing
- no aiming at player

### EnemyDiver.gd

- movement: swoop curves (sin or tweened path)
- no weapon

### EnemyWeapon.gd

- pattern enum: `SINGLE`, `DOUBLE`, `TRIPLE_FAN`
- fire cooldown
- spawns `EnemyBullet.tscn`

## Target Scaffold (Planned Paths)

```
/scenes
  /ui
    TitleScreen.tscn
    MainMenu.tscn
    HUD.tscn
    GameOver.tscn
    LevelComplete.tscn
  /game
    GameRoot.tscn
    Level1.tscn
  /player
    Player.tscn
  /enemies
    EnemyBase.tscn
    EnemyGunner.tscn
    EnemyDiver.tscn
  /projectiles
    PlayerBullet.tscn
    EnemyBullet.tscn
  /fx
    Explosion.tscn
/scripts
  /core
    GameState.gd
    SceneRouter.gd
    EventBus.gd        # optional but useful
    SaveStub.gd        # optional, empty placeholder for future
  /game
    LevelController.gd
    SpawnController.gd
    ScrollController.gd
  /player
    Player.gd
    PlayerWeapon.gd
    Health.gd
    Hurtbox.gd
    Hitbox.gd
  /enemies
    EnemyBase.gd
    EnemyGunner.gd
    EnemyDiver.gd
    EnemyWeapon.gd
  /projectiles
    BulletBase.gd
  /ui
    HUD.gd
    HpBar.gd
```

## Current Repo Snapshot (Existing Paths)

This reflects the current files already present in the repo. Keep this section
updated as the scaffolded layout is implemented or moved.

```
/scene
  airplanes.tscn
  background.tscn
  badguys.tscn
  main.tscn
  player.tscn
/scripts
  badguys.gd
  player.gd
```

## Core Game Loop

```
Boot Game
→ Title Screen
→ Main Menu (Press Start)
```
