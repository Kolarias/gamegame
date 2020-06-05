extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	match $"/root/Global".PlayerSelection:
		0:
			$Player2.queue_free()
		1:
			$Player.queue_free()
		_:
			print("Error in Players.gd function _ready(): Player Selection Value out of bounds")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_PlayerSelection(player):
	pass
