extends Area2D

export(float) var springImpulse = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered",self,"BodyEnteregToSpring")
	pass # Replace with function body.
	
func BodyEnteregToSpring(body):
	if (body.name==Globals.playerObjectName):
		$AnimatedSprite.play("Spring")
		Globals.player.ApplySpring(springImpulse)
		yield($AnimatedSprite,"animation_finished")
		$AnimatedSprite.play("Idle")
	print(body.name)
