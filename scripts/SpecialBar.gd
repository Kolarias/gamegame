extends TextureProgress


# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#receives special count update from player to update special counter bar
func _on_Player_spc_count_change(player):
	value = 100 - ( player.specialCount / player.SPECIAL_RDY ) * 100
