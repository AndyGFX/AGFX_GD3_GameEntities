extends Node

export var itemName = "undefined"

func _ready():
	pass

func _process(delta):	
	self.text = str(GameData.Get(itemName))
