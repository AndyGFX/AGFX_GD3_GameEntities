extends Path2D

export var moving_time = 2
export var playOnStart = false;

# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():
	
	$PathFollow2D/AnimationPlayer.playback_speed = self.moving_time
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
