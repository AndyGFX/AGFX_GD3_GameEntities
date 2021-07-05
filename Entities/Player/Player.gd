extends KinematicBody2D

export(float) var move_speed = 33
export(float) var x_max_speed = 250
export(float) var jump_impulse = 500
export(float) var wall_jump_horizontal_impulse = 175
export(float) var gravity = 50
export(bool) var slide_wall = true

var velocity : Vector2

func _physics_process(delta):
	# Get player input
	var axis = Vector2(
		Input.get_action_strength("player_right") - Input.get_action_strength("player_left"),
		Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	)
	
	if(axis.x > 0):
		$AnimatedSprite.flip_h = false
	elif(axis.x < 0):
		$AnimatedSprite.flip_h = true
	
	var is_jump_pressed = Input.is_action_just_pressed("player_jump")
	
	var next_move = velocity
	
	# X Move - clamp limits speed from going above a certain value on every frame
	if(axis.x != 0):
		next_move.x = clamp(next_move.x + (axis.x * move_speed), -x_max_speed, x_max_speed)
	else:
		if(is_on_floor()):
			next_move.x = lerp(next_move.x, 0, 0.6)
	
	# Y Move
	if(is_on_ceiling()):
		next_move.y = gravity
	elif(is_on_wall()):
		
		if !self.slide_wall:
			next_move.y = 0

		if(is_jump_pressed):
			# Raycasts would probably be a better solution here but this works
			# for now
			if($AnimatedSprite.flip_h):
				next_move.x = wall_jump_horizontal_impulse
			else:
				next_move.x = -wall_jump_horizontal_impulse				
			next_move.y -= jump_impulse
	else:
		next_move.y += gravity
	
	if(self.is_on_floor() && is_jump_pressed && !is_on_wall()):
		next_move.y -= jump_impulse
	
	
	velocity = move_and_slide_with_snap(next_move, Vector2.DOWN, Vector2.UP) 
