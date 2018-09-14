extends Popup

func win(player_id):
	$CenterContainer/VBoxContainer/Player.text = ApplyCustomization.Player_names[player_id]
	popup_centered()