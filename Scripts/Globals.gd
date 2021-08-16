extends Node

class_name GlobalStatics

# ---------------------------------------------------------------------------
# GAME ENUMS
# ---------------------------------------------------------------------------

# Movement facing state
enum eFacing { TO_LEFT, TO_RIGHT}

enum eMovementState { IDLE = 0,TO_LEFT = -1, TO_RIGHT=1, TO_UP = -1, TO_DOWN = 1, FALLING = 1, JUMP = -1 }

# Action state
enum eActionState { FIRE, THROW, USE }

# Animation state
enum eAnimationState { IDLE, WALK, JUMP, FALL, DIE, HURT, CLIMB, OBSTACLE, CRUNCH, CRUNCHWALK, WALLSLIDE, DASH, NONE }

# GhostEffect modes
enum eGhostEffectMode { ALWAYS, AIR, DASH, FALL, WALL }

# ---------------------------------------------------------------------------
# GAME data
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# GAME COMMON prefabs 
# ---------------------------------------------------------------------------

const pickupVFX = preload("res://Entities/Items/PickupAnimation/PickedVFX.tscn")
const playerGhostVFX = preload("res://Entities/Player/PlayerDushGhost.tscn")

# ---------------------------------------------------------------------------
# GAME Levels
# ---------------------------------------------------------------------------

var player = null
var playerObjectName = "undefined" # is set from GameManager script
var container = null

