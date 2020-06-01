extends KinematicBody2D

#member signals
signal hp_change(hp)
signal death

# Member constants, enum
const MOVE_SPEED = 550
const MAX_SPEED = 850
const FRICTION = 4
const MAX_HEALTH = 5.0

enum STATUS {DEAD, ALIVE}

#member variables
var velocity = Vector2()
var hp = MAX_HEALTH
var state = STATUS.ALIVE

#for player movement
var _up = "p_up"
var _down = "p_down"
var _left = "p_left"
var _right = "p_right"

#for aiming
var _lookUp = "l_up"
var _lookDown = "l_down"
var _lookLeft = "l_left"
var _lookRight = "l_right"

#for player actions
var _interact = "p_interact"

var _abilityOne = "p_one"
var _abilityTwo = "p_two"
var _abilityThree = "p_three"
var _abilityFour = "p_four"
var _abilitySpecial = "p_special"

var abilityOneCoolDown = 0
var abilityTwoCoolDown = 0
var abilityThreeCoolDown = 0
var abilityFourCoolDown = 0

var timer = 0

var abilitySpecialCoolDown = 0

onready var _screen_size_y = get_viewport_rect().size.y
onready var _screen_size_x = get_viewport_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("hp_change", self) #initialize hp bar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var inputX = Input.get_action_strength(_right) - Input.get_action_strength(_left)
	var inputY = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	var lookX = Input.get_action_strength(_lookRight) -  Input.get_action_strength(_lookLeft)
	var lookY = Input.get_action_strength(_lookDown) -  Input.get_action_strength(_lookUp)
	var abilityOne = Input.get_action_strength(_abilityOne)
	var abilityTwo = Input.get_action_strength(_abilityTwo)
	var abilityThree = Input.get_action_strength(_abilityThree)
	var abilityFour = Input.get_action_strength(_abilityFour)
	var abilitySpecial = Input.get_action_strength(_abilitySpecial)
	#get y input
	#reduce velocity y by friction constant when no y velocity is input
	if inputY == 0: velocity.y /= FRICTION 
	if abs(velocity.y) < MAX_SPEED:
		velocity.y += inputY * MOVE_SPEED * delta
	#if MAX_SPEED is reached keep speed constant
	else:
		if velocity.y < 0: velocity.y = -MAX_SPEED
		if velocity.y > 0: velocity.y = MAX_SPEED
	#get x input
	#reduce velocity x by friction constant when no x velocity is input
	if inputX == 0: velocity.x /= FRICTION
	#increase velocity x when 
	if abs(velocity.x) < MAX_SPEED:
		velocity.x += inputX * MOVE_SPEED * delta
	#if MAX_SPEED is reached, keep speed constant
	else:
		if velocity.x < 0: velocity.x = -MAX_SPEED
		if velocity.x > 0: velocity.x = MAX_SPEED
	
	if abilityOne > 0 && abilityOneCoolDown <= 0:
		get_child(0).abilityOne()
	elif abilityTwo > 0 && abilityTwoCoolDown <= 0:
		get_child(0).abilityTwo()
		abilityTwoCoolDown = 20
	elif abilityThree > 0 && abilityThreeCoolDown <= 0:
		get_child(0).abilityThree()
		abilityThreeCoolDown = 10
	elif abilityFour > 0 && abilityFourCoolDown <= 0:
		get_child(0).abilityFour()
		abilityFourCoolDown = 40
	elif abilitySpecial > 0 && abilitySpecialCoolDown <= 0:
		get_child(0).abilitySpecial()
		abilitySpecialCoolDown = 10000
	
	if timer > .2:
		abilityOneCoolDown -= 1
		abilityTwoCoolDown -= 1
		abilityThreeCoolDown -= 1
		abilityFourCoolDown -= 1
		timer = 0
		
	#temp
	abilitySpecialCoolDown = 0
	
	timer += delta
	
	#changes the direction the player is facing to aim
	get_child(0).look(lookX,lookY)
	
	#creates movement based on velocity vector
	move_and_slide(velocity)

#a function that handles player damage
func take_dmg(dmg):
	hp -= dmg
	emit_signal("hp_change", self)
	#check for death
	if hp <= 0:
		state = STATUS.DEAD
		$Death.play("Death")
		emit_signal("death")
	elif dmg > 0:
		$Hit.play("Hit")

#take damage when entering aoe damage area
func _on_aoe_dmg_body_shape_entered(body_id, body, body_shape, area_shape):
	take_dmg(1)
