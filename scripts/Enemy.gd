extends KinematicBody2D


# Declare member variables here. Examples:
var down_v = Vector2(0, 50)
var left_v = Vector2(50, 0)
var up_v = Vector2(0, -50)
var right_v = Vector2(-50, 0)
var time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	if fmod(round(time), 2) == 0:
		move_and_slide(down_v)
	else:
		move_and_slide(up_v)
