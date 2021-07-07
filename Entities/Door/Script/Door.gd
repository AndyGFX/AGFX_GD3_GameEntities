extends Area2D

func LockedDoor():
	$AnimatedSprite.play("Idle")
	
func OpenDoor():
	$AnimatedSprite.play("Opening")
	
func CloseDoor():
	$AnimatedSprite.play("Opening",true)
	
