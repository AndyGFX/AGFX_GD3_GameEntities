extends Area2D

export(String) var bodyName = "Player"
export(String) var targetNode = "undefined"
export(String) var onEnterCallback = "undefined"
export(String) var onExitCallback = "undefined"

func _ready():
	self.connect("body_entered",self,"BodyEnteredToZone")
	self.connect("body_exited",self,"BodyExitedFromZone")
	pass # Replace with function body.
	
func BodyEnteredToZone(body):
	if (body.name == self.bodyName):
		if (self.targetNode!="undefined"):
			var targetNode = Utils.FindNode(self.targetNode)
			if targetNode.has_method(self.onEnterCallback):
				targetNode.call(self.onEnterCallback)
	pass
	
func BodyExitedFromZone(body):
	if (body.name == self.bodyName):
		if (self.targetNode!="undefined"):
			var targetNode = Utils.FindNode(self.targetNode)
			if targetNode.has_method(self.onExitCallback):
				targetNode.call(self.onExitCallback)
		pass
	pass
