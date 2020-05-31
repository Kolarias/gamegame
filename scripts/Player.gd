extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MOVE_SPEED = 550
const MAX_SPEED = 850
const FRICTION = 10

var velocity = Vector2()

var _up = "p_up"
var _down = "p_down"
var _left = "p_left"
var _right = "p_right"

var _lookUp = "l_up"
var _lookDown = "l_down"
var _lookLeft = "l_left"
var _lookRight = "l_right"

var _interact = "p_interact"

var _abilityOne = "p_one"
var _abilityTwo = "p_two"
var _abilityThree = "p_three"
var _abilityFour = "p_four"
var _abilitySpecial = "p_special"

onready var _screen_size_y = get_viewport_rect().size.y
onready var _screen_size_x = get_viewport_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	pass #initialize something at some point, until then pass function

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#get y input
	var inputY = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	#reduce velocity y by friction constant when no y velocity is input
	if inputY == 0: velocity.y /= FRICTION 
	if abs(velocity.y) < MAX_SPEED:
		velocity.y += inputY * MOVE_SPEED * delta
	#if MAX_SPEED is reached keep speed constant
	else:
		if velocity.y < 0: velocity.y = -MAX_SPEED
		if velocity.y > 0: velocity.y = MAX_SPEED
	#get x input
	var inputX = Input.get_action_strength(_right) - Input.get_action_strength(_left)
	#reduce velocity x by friction constant when no x velocity is input
	if inputX == 0: velocity.x /= FRICTION
	#increase velocity x when 
	if abs(velocity.x) < MAX_SPEED:
		velocity.x += inputX * MOVE_SPEED * delta
	#if MAX_SPEED is reached, keep speed constant
	else:
		if velocity.x < 0: velocity.x = -MAX_SPEED
		if velocity.x > 0: velocity.x = MAX_SPEED
	#creates movement based on velocity vector
	
	var lookX = Input.get_action_strength(_lookRight) -  Input.get_action_strength(_lookLeft)

	var lookY = Input.get_action_strength(_lookDown) -  Input.get_action_strength(_lookUp)

	get_child(0).look(lookX,lookY)
	
	move_and_slide(velocity)
	
