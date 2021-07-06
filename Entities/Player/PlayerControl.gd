extends KinematicBody2D

export(float) var speed = 500
export(float) var max_speed = 150
export(float) var friction = 0.5
export(float) var gravity = 300
export(float) var jump = 150
export(float) var resistance = 0.7
export(Vector2) var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite

func _ready():
	pass


func _physics_process(delta):
	var movement_x = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	if movement_x !=0:
		sprite.play("Run");
		velocity.x += movement_x*speed*delta
		velocity.x = clamp(velocity.x,-max_speed,max_speed)
		sprite.flip_h = movement_x < 0
	
	if is_on_floor():
		if movement_x == 0:
			sprite.play("Idle");
			velocity.x = lerp(velocity.x,0,friction)
		if Input.is_action_pressed("player_jump"):
			velocity.y -= jump
			sprite.play("Jump");
	else:
		if movement_x == 0:
			sprite.play("Fall");
			velocity.x = lerp(velocity.x,0,resistance)
			
	velocity.y += gravity*delta
	velocity = move_and_slide(velocity,Vector2.UP)
