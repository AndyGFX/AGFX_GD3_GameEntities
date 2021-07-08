extends AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play()
	yield(self, "animation_finished") 
	queue_free()

