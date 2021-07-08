extends ItemEntity

func _ready():
	self.item_amount = 10
	self.item_limit = 100
	pass # Replace with function body.
	
func OnPickup(body):
	print("Item: " + self.item_type+" picked by "+body.name)
	print(GameData.Get(self.item_type))

