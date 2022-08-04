extends KinematicBody2D

export(float) var speed = 500
export(float) var max_walk_speed = 50
export(float) var max_run_speed = 100
export(float) var friction = 0.5
export(float) var gravity = 300
export(float) var jump = 150
export(float) var wall_slide_speed = 20

export(float) var spring = 300
export(bool) var useGhostEffect = true
export(GlobalStatics.eGhostEffectMode) var ghostEffectMode = GlobalStatics.eGhostEffectMode.ALWAYS
export(int) var maxJumpCount = 1
export(bool) var wallSlide = true
export(bool) var dash = true
export(float) var dashImpulse = 1000
export(float) var dashTime = 0.3

var velocity:Vector2 = Vector2.ZERO
var movement:float = 0
var jumpCount:int = 0
var isOnGround:bool = false
var isOnWall:bool = false
var isOnAir:bool = false
var inCrunch:bool = false
var inJumping:bool = false
var inRunning:bool = false
var inHurt:bool = false
var dashDirection:Vector2 = Vector2.RIGHT
var canDash:bool = true
var isDashing:bool = false

onready var sprite = $AnimatedSprite
var animation_state = Globals.eAnimationState.IDLE
var current_animation = Globals.eAnimationState.NONE
var dashTimer = null
var speed_backup:float = 0


# ------------------------------------------------------------------------------
# On READY:
# ------------------------------------------------------------------------------
func _ready():
	
	var repeat_time:float = 0.1
	
	if (self.ghostEffectMode == GlobalStatics.eGhostEffectMode.DASH):
		repeat_time = 0.025
		
	# prepare timer for ghost effect
	if self.useGhostEffect:
		self.dashTimer = Utils.CreateTimer(repeat_time,self,"GhostEffect",false,true)
	else:
		self.dashTimer = Utils.CreateTimer(repeat_time,self,"GhostEffect",false,false)
		
	self.speed_backup = self.max_walk_speed
	Globals.player = self
	pass

# ------------------------------------------------------------------------------
# Apply impulse when player hit spring (called from SpringEntity)
# ------------------------------------------------------------------------------
func ApplySpring(impulse:float):	
	velocity.y = -impulse

# ------------------------------------------------------------------------------
# On UPDATE:
# ------------------------------------------------------------------------------
func _physics_process(delta):
	
	self._Input()
	self._Dash()
	self._WalkAndRun(delta)
	self._Crunch()
	self._Jump()
	self._WallSlide()
	self._ApplyVelocity(delta)
	self._SetCollisionStates()
	self._SetMovementState()
	self._PlayAnimationByState()
	
# ------------------------------------------------------------------------------
# DASH VFX fro PLAYER
# ------------------------------------------------------------------------------
func _Dash()->void:
	if self.dash:
		
		if self.isOnGround:
			self.canDash = true
		
		if Input.is_action_pressed("player_left"):
			self.dashDirection = Vector2.LEFT
		
		if Input.is_action_pressed("player_right"):
			self.dashDirection = Vector2.RIGHT
		
		if Input.is_action_just_pressed("player_dash") and self.canDash:
			self.velocity = self.dashDirection*self.dashImpulse			
			self.max_walk_speed = self.dashImpulse/3.0;
			self.canDash = false
			self.isDashing = true
			yield(get_tree().create_timer(self.dashTime),"timeout")
			self.isDashing = false
			self.max_walk_speed = self.speed_backup
			pass
	pass


# ------------------------------------------------------------------------------
# Ghost effect - called from timer
# ------------------------------------------------------------------------------
func GhostEffect()->void:
	var enabled:bool = false
	
	match (self.ghostEffectMode):
		GlobalStatics.eGhostEffectMode.ALWAYS:
			enabled = true
			pass
		GlobalStatics.eGhostEffectMode.WALL:
			if self.isOnWall: enabled = true
			pass
		GlobalStatics.eGhostEffectMode.FALL:
			if self.isOnAir: enabled = true
			pass
		GlobalStatics.eGhostEffectMode.DASH:
			if self.isDashing : enabled = true
			pass
	
	if enabled:
		var ghost = Globals.playerGhostVFX.instance();
		get_parent().add_child(ghost)
		ghost.position = position	
		ghost.texture = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation,$AnimatedSprite.frame)
		ghost.flip_h = $AnimatedSprite.flip_h
	
	

# ******************************************************************************
# HELPERS
# ******************************************************************************

func _Input()->void:
	# ? input left/stand/right
	self.movement = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")

# ------------------------------------------------------------------------------
# Check an prepare movement state for play animation
# ------------------------------------------------------------------------------
func _SetMovementState():
	
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
				if self.wallSlide: self.animation_state = Globals.eAnimationState.WALLSLIDE
			else:
				if !self.inCrunch:
					self.animation_state = Globals.eAnimationState.FALL

	if self.inJumping and self.velocity.y<0:
		if !self.inCrunch:
			self.animation_state = Globals.eAnimationState.JUMP
	
	if self.inHurt: self.animation_state = Globals.eAnimationState.HURT
	
	if self.isDashing:
		self.animation_state = Globals.eAnimationState.DASH

# ------------------------------------------------------------------------------
# Play animation by state
# before you need call SetupMovementState method
# ------------------------------------------------------------------------------
func _PlayAnimationByState():
	
	var _anim_name=""
	
	if self.animation_state==Globals.eAnimationState.IDLE: _anim_name = "Idle"
	if self.animation_state==Globals.eAnimationState.WALK: _anim_name = "Run"
	if self.animation_state==Globals.eAnimationState.JUMP: _anim_name = "Jump"
	if self.animation_state==Globals.eAnimationState.FALL: _anim_name = "Fall"
	if self.animation_state==Globals.eAnimationState.DASH: _anim_name = "Dash"
#	if self.animation_state==Globals.eAnimationState.HURT: _anim_name = "Hurt"
	if self.animation_state==Globals.eAnimationState.CRUNCH: _anim_name = "Ducking"
	if self.animation_state==Globals.eAnimationState.WALLSLIDE: _anim_name = "WallSlide"
	if self.animation_state==Globals.eAnimationState.CRUNCHWALK: _anim_name = "DuckingWalk"
	
	if self.current_animation != self.animation_state:
		self.sprite.play(_anim_name)
		self.current_animation = animation_state
		
func _WalkAndRun(delta)->void:
	if !movement==0:
		# increase move speed
		if !self.isDashing:
			velocity.x += self.movement*speed*delta
		
		if Input.is_action_pressed("player_run"):
			velocity.x = clamp(velocity.x,-self.max_run_speed,self.max_run_speed)
		else:
			velocity.x = clamp(velocity.x,-self.max_walk_speed,self.max_walk_speed)
		sprite.flip_h = self.movement < 0
		
	else:
		# slow down when key isn't pressed
		velocity.x = lerp(velocity.x,0,friction)

func _Crunch()->void:
	if self.isOnGround:
		self.inJumping = false
		self.jumpCount = self.maxJumpCount;
		
		# ? and is crunch key pressed ?
		if Input.is_action_just_pressed("player_crunch"):
			self.inCrunch = !self.inCrunch
			
			if self.inCrunch:
				$CollisionShape2D_CRUNCH.set_deferred("disabled",false)
				$CollisionShape2D_WALK.set_deferred("disabled",true)
			else:
				$CollisionShape2D_CRUNCH.set_deferred("disabled",true)
				$CollisionShape2D_WALK.set_deferred("disabled",false)


func _Jump()->void:
	# ? and is jump key pressed ?
	if Input.is_action_just_pressed("player_jump"):
		if (self.jumpCount>0):
			self.inJumping = true
			self.velocity.y -= self.jump
			self.jumpCount -= 1	

func _WallSlide()->void:
	# ? is on WALL 
	if self.isOnWall and self.wallSlide:
		if velocity.y>30:
			velocity.y = self.wall_slide_speed
	

func _ApplyVelocity(delta)->void:
	
	# apply gravity
	velocity.y += gravity*delta
	
	# MOVE and SLIDE
	velocity = move_and_slide(velocity,Vector2.UP)
	
func _SetCollisionStates()->void:
	self.isOnGround = self.is_on_floor()	
	self.isOnWall = self.is_on_wall()
	self.isOnAir = !self.is_on_floor()
	
