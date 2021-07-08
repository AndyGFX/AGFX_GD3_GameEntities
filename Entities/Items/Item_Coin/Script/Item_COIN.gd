extends ItemEntity

func _ready():
	pass # Replace with function body.
	
func OnPickup(body):
	print("Item: " + self.item_type+" picked by "+body.name)
	print(GameData.Get(self.item_type))

