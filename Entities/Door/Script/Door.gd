extends Area2D

export(String) var targetObjectName = "undefined"
export(String) var targetCallback = "callback"

func _ready():
	self.connect("body_entered",self,"BodyEnteregToDoor")
	$EnterAreaTrigger.set_deferred("disabled",true)
	
	

func LockedDoor():
	$AnimatedSprite.play("Idle")
	
func OpenDoor():
	$EnterAreaTrigger.set_deferred("disabled",false)
	$AnimatedSprite.play("Opening")
	
	
func CloseDoor():
	$EnterAreaTrigger.set_deferred("disabled",true)
	$AnimatedSprite.play("Opening",true)
	
func BodyEnteregToDoor(body):
	print(body.name)
	if (body.name==Globals.playerObjectName):
		if (self.targetObjectName!="undefined"):
			var targetNode = Utils.FindNode(self.targetObjectName)
			if targetNode.has_method(self.targetCallback):
				# your code here or
				targetNode.call(targetCallback) # in target object		
		print("Player entered to DOOR")
		pass
	
	pass
