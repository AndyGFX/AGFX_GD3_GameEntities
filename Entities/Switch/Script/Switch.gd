extends Area2D


# scene node name
export(String) var targetObjectName = "undefined"
export(String) var targetCallback = "OpenDoor"

func _ready():
	self.connect("body_entered",self,"BodyEnteregToSwitch")
	pass # Replace with function body.
	
func BodyEnteregToSwitch(body):
	if (body.name=="Player"):
		$AnimatedSprite.play("Active")
		
		if (self.targetObjectName!="undefined"):
			var targetNode = Utils.FindNode(self.targetObjectName)
			if targetNode.has_method(self.targetCallback):
				targetNode.call(targetCallback)
			
		yield($AnimatedSprite,"animation_finished")
		$AnimatedSprite.play("IdleActive")		
	else:
		$AnimatedSprite.play("Idle")
	print(body.name)

