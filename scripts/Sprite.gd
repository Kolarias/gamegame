extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	set_texture(load("textures//charOne.png"))

func look(x,y):
	if (y == 0) && (x > 0): set_texture(load("textures//NR.png"))
	elif (y < 0) && (x > 0): set_texture(load("textures//UR.png"))
	elif (y < 0) && (x == 0): set_texture(load("textures//UN.png"))
	elif (y < 0) && (x < 0): set_texture(load("textures//UL.png"))
	elif (y == 0) && (x < 0): set_texture(load("textures//NL.png"))
	elif (y > 0) && (x < 0): set_texture(load("textures//DL.png"))
	elif (y > 0) && (x == 0): set_texture(load("textures//DN.png"))
	elif (y > 0) && (x > 0): set_texture(load("textures//DR.png"))

func abilityOne():
	set_texture(load("textures//abilityOne.png"))
	
func abilityTwo():
	set_texture(load("textures//abilityTwo.png"))
	
func abilityThree():
	set_texture(load("textures//abilityThree.png"))
	
func abilityFour():
	set_texture(load("textures//abilityFour.png"))
	
func abilitySpecial():
	set_texture(load("textures//abilitySpecial.png"))
