extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#a function that receives the player info and converts ability cooldown values
#to the gui cooldown display. converts countdowns to degrees
func _on_Player_ability_gui(player):
	$AOne.value = 100 - ( float(player.abilityOneCoolDown) / player.COOLDOWN.ONE ) * 100
	$ATwo.value = 100 - ( float(player.abilityTwoCoolDown) / player.COOLDOWN.TWO ) * 100
	$AThree.value = 100 - ( float(player.abilityThreeCoolDown) / player.COOLDOWN.THREE ) * 100
	$AFour.value = 100 - ( float(player.abilityFourCoolDown) / player.COOLDOWN.FOUR ) * 100
