extends Node

# ---------------------------------------------------------------------------
# GAME ENUMS
# ---------------------------------------------------------------------------

# Movement facing state
enum eFacing { TO_LEFT, TO_RIGHT}

enum eMovementState { IDLE = 0,TO_LEFT = -1, TO_RIGHT=1, TO_UP = -1, TO_DOWN = 1, FALLING = 1, JUMP = -1 }

# Action state
enum eActionState { FIRE, THROW, USE }

# Animation state
enum eAnimationState { IDLE, WALK, JUMP, FALL, DIE, HURT, CLIMB, OBSTACLE, CRUNCH, CRUNCHWALK, WALLSLIDE, NONE }


# ---------------------------------------------------------------------------
# GAME data
# ---------------------------------------------------------------------------
var coins = 0;
var health = 0;
var items = {};

# ---------------------------------------------------------------------------
# GAME prefabs 
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# GAME Levels
# ---------------------------------------------------------------------------

var player = null

