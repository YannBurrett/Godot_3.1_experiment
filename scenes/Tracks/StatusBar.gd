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