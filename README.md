# Godot 3.2 - Game Entities LIBRARY

## Base scene template [File: Scenes/EmptyScene.tscn]
- EmptyScene + res://Scripts/Managers/GameManager.gd assigned
- Tilemap_BKG
- Tilemap_WALLS
- Player (external object: res://Entities/Player/Player.tscn) 
- Project setting / Autoload 
    - res://Scripts/Globals.gd
    - res://Scripts/Utils/Utils.gd
    - res://Scripts/Utils/GameData.gd

## Platform PLAYER control - keys
- [Q] - sword attack
- [W] - fire attack
- [E] - use/activate
- [D] - Dash
- [C] - Crunch
- [shift] - run
- [<- , ->] - walk

## Platformer character controler [File: Scenes/DEMO_PlatfromerCharacter.tscn]
- move left/right
- jump (with flag for jump count)
- wall sliding (on/off)
- user defined movement parameters (speed, jump, gravity, friction, spring, ... )
- player ghost effect with a few modes (ALWAYS, FALL, DASH, WALL)


## Breaking platfrom [File: Scenes/Demo_BreakingPlatfrom.tscn]

- when player hit platform, breaking animation start
- after animation end, platform is removed on `animation_finished` event
- breaking time is animation length 

## Pickup Coin [File: Scene/Demo_PickupCoins.tscn]
- pickup entity and store count in GameData under key=COIN

## Pickup Health [File: Scene/Demo_PickupHealth.tscn]
- pickup entity and store count in GameData under key=HEALTH
- when limit value is reached, then pickup event ignore new health item

## Spring [File: Scene/Demo_Spring.tscn]
- user defined spring impulse

## Open door with switch [File: Scene/Demo_SwitchAndDoor.tscn]
- when player hit switch, opening animation start and EnterAreaTrigger is enabled
- EnterAreaTrigger is preset for user defined signal ...
- connection between switch and door is connected with line (in editot only)

    

