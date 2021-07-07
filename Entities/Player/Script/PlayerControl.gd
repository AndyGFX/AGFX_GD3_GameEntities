extends KinematicBody2D

export(float) var speed = 500
export(float) var max_speed = 150
export(float) var friction = 0.5
export(float) var gravity = 300
export(float) var jump = 150
export(float) var wall_slide_speed = 20
export(float) var resistance = 0.7
export(float) var spring = 300
export(Vector2) var velocity = Vector2.ZERO

export(Globals.eMovementState) var mState

var movement:float = 0
var maxJumpCount:int = 2
var jumpCount:int = 0

var isOnGround:bool = false
var isOnWall:bool = false
var isOnAir:bool = false
var inCrunch:bool = false
var inJumping:bool = false
var inHurt:bool = false


onready var sprite = $AnimatedSprite
var animation_state = Globals.eAnimationState.IDLE
var current_animation = Globals.eAnimationState.NONE


# ------------------------------------------------------------------------------
# On READY:
# ------------------------------------------------------------------------------
func _ready():
	Globals.player = self
	pass

# ------------------------------------------------------------------------------
# Apply impulse when player hit spring (called from SpringEntity)
# ------------------------------------------------------------------------------
func ApplySpring(value:float):	
	velocity.y = -value 

# ------------------------------------------------------------------------------
# On UPDATE:
# ------------------------------------------------------------------------------
func _physics_process(delta):
	
	# ? input left/stand/right
	self.movement = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	
	# if is LEFT/RIGHT key pressed
	if !movement==0:
		# increase move speed
		velocity.x += self.movement*speed*delta
		velocity.x = clamp(velocity.x,-max_speed,max_speed)	
		sprite.flip_h = self.movement < 0
	else:
		# slow down when key isn't pressed
		velocity.x = lerp(velocity.x,0,friction)
	
	# ? is on GROUND 
	if self.isOnGround:
		self.inJumping = false
		self.jumpCount = self.maxJumpCount;
		
		# ? and is jump key pressed ?
		if Input.is_action_just_pressed("player_jump"):
			self.inJumping = true
			self.velocity.y -= self.jump
			pass
		
		# ? and is crunch key pressed ?
		if Input.is_action_just_pressed("player_crunch"):
			self.inCrunch = !self.inCrunch
			pass
			
		pass
	
	# ? is on WALL 
	if self.isOnWall:
		if velocity.y>30:
			velocity.y = self.wall_slide_speed
	
	# apply gravity
	velocity.y += gravity*delta
	
	# MOVE and SLIDE
	velocity = move_and_slide(velocity,Vector2.UP)

	self.isOnGround = self.is_on_floor()	
	self.isOnWall = self.is_on_wall()
	self.isOnAir = !self.is_on_floor()

	self.SetupMovementState()
	self.PlayAnimation()

# ------------------------------------------------------------------------------
# Check an prepare movement state for play animation
# ------------------------------------------------------------------------------
func SetupMovementState():
	
# Set animation 
	
	if self.isOnGround:
		if self.movement!=0:
			if !self.isOnWall:
				if self.inCrunch:
					self.animation_state = Globals.eAnimationState.CRUNCHWALK
				else:
					self.animation_state = Globals.eAnimationState.WALK
		else:
			if self.inCrunch:
				self.animation_state = Globals.eAnimationState.CRUNCH
			else:
				self.animation_state = Globals.eAnimationState.IDLE
	else:
		if self.velocity.y>0:
			if self.isOnWall:
				self.animation_state = Globals.eAnimationState.WALLSLIDE
			else:
				self.animation_state = Globals.eAnimationState.FALL
			
	if self.inJumping and self.velocity.y<0: 
		self.animation_state = Globals.eAnimationState.JUMP
	
	if self.inHurt: self.animation_state = Globals.eAnimationState.HURT

# ------------------------------------------------------------------------------
# Play animation by state
# before you need call SetupMovementState method
# ------------------------------------------------------------------------------
func PlayAnimation():
	
	var _anim_name=""
	
	if self.animation_state==Globals.eAnimationState.IDLE: _anim_name = "Idle"
	if self.animation_state==Globals.eAnimationState.WALK: _anim_name = "Run"
	if self.animation_state==Globals.eAnimationState.JUMP: _anim_name = "Jump"
	if self.animation_state==Globals.eAnimationState.FALL: _anim_name = "Fall"
#	if self.animation_state==Globals.eAnimationState.HURT: _anim_name = "Hurt"
	if self.animation_state==Globals.eAnimationState.CRUNCH: _anim_name = "Ducking"
	if self.animation_state==Globals.eAnimationState.WALLSLIDE: _anim_name = "WallSlide"
	if self.animation_state==Globals.eAnimationState.CRUNCHWALK: _anim_name = "DuckingWalk"
	
	if self.current_animation != self.animation_state:
		self.sprite.play(_anim_name)
		self.current_animation = animation_state
		
