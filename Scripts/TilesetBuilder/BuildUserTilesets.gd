extends Node2D
var Builder =  TilesetBuilder.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var images_json = {
		"0" : {"name": "Prototype_001" ,"width":16,"height":16, "src":"res://Sprites/Tiles/CTS_Prototype_001.png", "collshape":true},
		"1" : {"name": "Prototype_002" ,"width":16,"height":16, "src":"res://Sprites/Tiles/CTS_Prototype_002.png", "collshape":true},
		"2" : {"name": "Prototype_003" ,"width":16,"height":16, "src":"res://Sprites/Tiles/CTS_Prototype_003.png", "collshape":true},
		"3" : {"name": "Prototype_004" ,"width":16,"height":16, "src":"res://Sprites/Tiles/CTS_Prototype_004.png", "collshape":false},
	}
	
	Utils.SaveJSON("res://Sprites/Tiles/TilesetImages.data",images_json,true)
	
	Builder.BuildFromFile(Utils.LoadJSON("res://Sprites/Tiles/TilesetImages.data"),"res://TileSet/ProrotypeTilsets.tres")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
