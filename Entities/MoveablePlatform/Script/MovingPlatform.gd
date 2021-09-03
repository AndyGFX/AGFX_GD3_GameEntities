"""Moving platform, moves to target positions given by the Waypoints node"""
tool
extends KinematicBody2D

onready var wait_timer: Timer = $Timer
onready var waypoints: = get_node(waypoints_path)

export var editor_process: = true setget set_editor_process
export var speed: = 0.0
export var waypoints_path: = NodePath()

var target_position: = Vector2()

func _ready() -> void:
	if not waypoints:
		set_physics_process(false)
		return
		
	
	position = waypoints.get_start_position()
	target_position = waypoints.get_next_point_position()
	self.connect("timeout" , $Timer, "_on_Timer_timeout")


func _physics_process(delta: float) -> void:
	var direction: = (target_position - position).normalized()
	var motion: = direction * speed * delta
	var distance_to_target: = position.distance_to(target_position)
	if motion.length() > distance_to_target:
		position = target_position
		target_position = waypoints.get_next_point_position()
		set_physics_process(false)
		wait_timer.start()
	else:
		position += motion

#
#func _draw() -> void:
#	var shape: = $CollisionShape2D
#	var extents: Vector2 = shape.shape.extents * 2.0
#	var rect: = Rect2(shape.position - extents / 2.0, extents)
#	draw_rect(rect, Color('fff'))


func set_editor_process(value:bool) -> void:
	editor_process = value
	if not Engine.editor_hint:
		return
	if waypoints:
		set_physics_process(value)

#set_physics_process(true)




func _on_Timer_timeout():
	set_physics_process(true)