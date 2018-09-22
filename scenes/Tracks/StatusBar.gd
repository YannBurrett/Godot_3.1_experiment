extends NinePatchRect

var total_laps

export var player_id = 1

func _ready():
	$HBoxContainer/Name.text = ApplyCustomization.Player_names[player_id]
	total_laps = ApplyCustomization.laps

func track_lap(player, lap):
	if player_id == player:
		if lap +1 == total_laps:
			$HBoxContainer/Lap.text = "Final Lap!"
		elif lap +1 > total_laps:
			$HBoxContainer/Lap.text = "Race Complete"
		else:
			$HBoxContainer/Lap.text = ("Lap " + str(lap +1) + " of " + str(total_laps))
	
func placement(player, place):
	if player_id == player:
		if place == 1:
			$TextureRect/Position.text = "1st"
		elif place == 2:
			$TextureRect/Position.text = "2nd"
		elif place == 3:
			$TextureRect/Position.text = "3rd"
		elif place == 4:
			$TextureRect/Position.text = "4th"
		else:
			$TextureRect/Position.text = "error"