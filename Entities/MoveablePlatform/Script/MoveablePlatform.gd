extends Path2D

export (float) var move_speed = 10

var following_path:bool = false
var path_follow:PathFollow2D = null

func _ready():
	self.path_follow  = $PathFollow2D
	self.following_path = true
		


func _physics_process(delta):
	if self.following_path:
		self.path_follow.offset += self.move_speed*delta
		if path_follow.unit_offset >= 1:
			path_follow.unit_offset = 1
			following_path = false

		$Platform.position = path_follow.position
