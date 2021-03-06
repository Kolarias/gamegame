extends KinematicBody2D

#member signals
signal hp_change
signal death
signal spc_count_change
signal ability_gui

# Member constants, enum
const MOVE_SPEED = 550
const MAX_SPEED = 850
const FRICTION = 2.8
const MAX_HEALTH = 20.0
const SPECIAL_RDY = 10.0

enum STATUS {DEAD, ALIVE}
enum COOLDOWN { ONE = 1, TWO = 20, THREE = 10, FOUR = 40 }

#member variables
var velocity = Vector2()
var hp = MAX_HEALTH
var state = STATUS.ALIVE
var specialCount = SPECIAL_RDY

#use to give more health and damage 
#maybe put this and the special counter in an if looking for kills
var level = 0
#put in 0s for all items and then just increment the correct index
#when the player comes in contact with an item
var items = [0,0,0]

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

#ability cooldown counters
var abilityOneCoolDown = 0
var abilityTwoCoolDown = 0
var abilityThreeCoolDown = 0
var abilityFourCoolDown = 0
var abilitySpecialCoolDown = 0

var timer = 0

onready var _screen_size_y = get_viewport_rect().size.y
onready var _screen_size_x = get_viewport_rect().size.x

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("hp_change", self) #initialize hp bar
	emit_signal("spc_count_change", self) #initialize special counter bar

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#get x and y movement input
	var inputX = Input.get_action_strength(_right) - Input.get_action_strength(_left)
	var inputY = Input.get_action_strength(_down) - Input.get_action_strength(_up)
	
	#get aiming input
	var lookX = Input.get_action_strength(_lookRight) -  Input.get_action_strength(_lookLeft)
	var lookY = Input.get_action_strength(_lookDown) -  Input.get_action_strength(_lookUp)
	
	#get player action input
	var abilityOne = Input.get_action_strength(_abilityOne)
	var abilityTwo = Input.get_action_strength(_abilityTwo)
	var abilityThree = Input.get_action_strength(_abilityThree)
	var abilityFour = Input.get_action_strength(_abilityFour)
	var abilitySpecial = Input.get_action_strength(_abilitySpecial)
	
	#reduce velocity y by friction constant when no y velocity is input
	if inputY == 0: velocity.y /= FRICTION 
	#increase velocity y when below max speed
	if abs(velocity.y) < MAX_SPEED:
		velocity.y += inputY * MOVE_SPEED * delta
	#if MAX_SPEED is reached keep speed constant
	else:
		if velocity.y < 0: velocity.y = -MAX_SPEED
		if velocity.y > 0: velocity.y = MAX_SPEED
	
	#reduce velocity x by friction constant when no x velocity is input
	if inputX == 0: velocity.x /= FRICTION
	#increase velocity x when below max speed
	if abs(velocity.x) < MAX_SPEED:
		velocity.x += inputX * MOVE_SPEED * delta
	#if MAX_SPEED is reached, keep speed constant
	else:
		if velocity.x < 0: velocity.x = -MAX_SPEED
		if velocity.x > 0: velocity.x = MAX_SPEED
	
	#use an ability, prioritizes lower abilities over later abilities (1 -> 4)
	if abilityOne > 0 && abilityOneCoolDown <= 0:
		get_child(0).abilityOne()
	elif abilityTwo > 0 && abilityTwoCoolDown <= 0:
		get_child(0).abilityTwo()
		abilityTwoCoolDown = COOLDOWN.TWO
	elif abilityThree > 0 && abilityThreeCoolDown <= 0:
		get_child(0).abilityThree()
		abilityThreeCoolDown = COOLDOWN.THREE
	elif abilityFour > 0 && abilityFourCoolDown <= 0:
		get_child(0).abilityFour()
		abilityFourCoolDown = COOLDOWN.FOUR
	elif abilitySpecial > 0 && abilitySpecialCoolDown <= 0:
		get_child(0).abilitySpecial()
		abilitySpecialCoolDown = 10000
	
	#timer that decreases ability cooldowns, with .2 second precision
	#also sends signal to gui to update cooldown displays
	if timer > .2:
		abilityOneCoolDown -= 1
		abilityTwoCoolDown -= 1
		abilityThreeCoolDown -= 1
		abilityFourCoolDown -= 1
		emit_signal("ability_gui", self)
		timer = 0
		
	#temporarily set special cooldown to 0 for testing
	abilitySpecialCoolDown = 0
	
	#timer value
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

#take damage when touching enemy
func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	take_dmg(1)
