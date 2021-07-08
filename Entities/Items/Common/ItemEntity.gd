extends Area2D
class_name ItemEntity

export(String) var item_type = "undefined"
export(String) var item_owner = "Player"
export(int) var item_amount = 1
export(int) var item_id = 0
export(int) var item_limit = 999

func _ready():
	self.connect("body_entered",self,"Pickup")
	

# pickup item method is called from area detector assigned on player
func Pickup(body)-> void:
	
	if !GameData: return
	
	if (body.name==self.item_owner):
		if GameData.Get(item_type)>=item_limit: return
		GameData.AddWithLimitCheck(item_type,item_amount,item_limit);	
		Utils.Instantiate(Globals.pickupVFX,get_global_position())
		#Globals.player_sfx.Play("Pickup")
		self.OnPickup(body)
		queue_free()
	
# remove collision shape when is item used as item inside chest
# for disable when is chest closed and enabled, when is onened
func PickupControl(state)-> void:	
	$CollisionShape2D.set_deferred("disabled",!state)
	
func OnPickup(body):
	pass 
