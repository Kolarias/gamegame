extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load("yap1b9yc9k001.jpg"))

func look(x,y):
	if (y == 0) && (x > 0): set_texture(load("NR.png"))
	elif (y < 0) && (x > 0): set_texture(load("UR.png"))
	elif (y < 0) && (x == 0): set_texture(load("UN.png"))
	elif (y < 0) && (x < 0): set_texture(load("UL.png"))
	elif (y == 0) && (x < 0): set_texture(load("NL.png"))
	elif (y > 0) && (x < 0): set_texture(load("DL.png"))
	elif (y > 0) && (x == 0): set_texture(load("DN.png"))
	elif (y > 0) && (x > 0): set_texture(load("DR.png"))
