extends Control

# Declare member variables here. Examples:
signal PlayerSelection()
var player = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#unchecks
func _on_pOne_toggled(button_pressed):
	if $PlayerSelect/pOne.pressed == true:
		$PlayerSelect/pTwo.pressed = false
		player = 0


func _on_pTwo_toggled(button_pressed):
	if $PlayerSelect/pTwo.pressed == true:
		$PlayerSelect/pOne.pressed = false
		player = 1


func _on_Start_pressed():
	#todo: add check that player is selected
	get_tree().change_scene("res://Level1.tscn")
	$"/root/Global".PlayerSelection = player
