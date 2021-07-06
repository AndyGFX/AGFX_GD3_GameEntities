extends Area2D

func _ready():
	$AnimatedSprite.connect("animation_finished" , self, "AnimationFinished")
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimatedSprite.play("Break");
	
func AnimationFinished():
	self.queue_free()
	pass

