tool
extends Area2D


# scene node name
export(String) var targetObjectName = "undefined"
export(String) var targetCallback = "OpenDoor"

func _ready():
	self.connect("body_entered",self,"BodyEnteregToSwitch")
	pass # Replace with function body.

func _process(delta):	
	self.update()

func BodyEnteregToSwitch(body):
	if (body.name==Globals.playerObjectName):
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


# -------------------------------------------------------
# DRAW
# -------------------------------------------------------
func _draw():
	if Engine.is_editor_hint():
		self.DrawConnection()
		
		
func DrawConnection():
	if (self.targetObjectName!="undefined"):
		var targetNode = get_tree().get_root().find_node(self.targetObjectName, true, false)
		var p_from = Vector2.ZERO
		var p_to = targetNode.get_position()-self.get_position()
		self.draw_line(p_from,p_to,Color.green,1,true)
		
	
