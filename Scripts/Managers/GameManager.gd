extends Node2D

export (String) var playerObjectName = "Player"
export (bool) var resetGameData = true
export (bool) var createContainer = true

func _ready():
	
	# --------------------------------------------------------------------------
	# Check GameData singleton
	# --------------------------------------------------------------------------
	if !GameData:
		print ("ERROR: Missing GameData.gd included to AutoLoad");
		get_tree().quit()
		
	# --------------------------------------------------------------------------
	# Check Utils singleton
	# --------------------------------------------------------------------------
	if !Utils:
		print ("ERROR: Missing Utils.gd included to AutoLoad");
		get_tree().quit()
	
	# --------------------------------------------------------------------------
	# Check Utils singleton
	# --------------------------------------------------------------------------
	if !Globals:
		print ("ERROR: Missing Globals.gd included to AutoLoad");
		get_tree().quit()
	
	# --------------------------------------------------------------------------
	# Find and assign Player object
	# --------------------------------------------------------------------------
	
	Globals.player = Utils.FindNode(self.playerObjectName)
	
	# --------------------------------------------------------------------------
	# GameData
	# --------------------------------------------------------------------------
	
	if self.resetGameData:
		GameData.Set('coins',0)
		GameData.Set('health',50)
		GameData.Save()
		
	GameData.Load()
	
	# --------------------------------------------------------------------------
	# Check container
	# find container instance in scene
	# --------------------------------------------------------------------------	
	Globals.container =  Utils.FindNode("Container")
	
	if !createContainer:
		if !Globals.container:
			print("ERROR: Missing Node2D object with name Container in scene. Create it manualy or set createContainer=true in inspector")
			get_tree().quit()

	# create container instance in scene if missing
	if !Globals.container and self.createContainer:
		Globals.container = Node2D.new();
		Globals.container.set_name("Container")
		get_parent().call_deferred("add_child",Globals.container)
		print("Container created ...")	
	
	
	
	
	
	
	
