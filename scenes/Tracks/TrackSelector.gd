extends Control



func _on_Race_Button_pressed():
	var track = $VBoxContainer2/HBoxContainer/TrackContainer/TrackSelect.selected
	var laps = $VBoxContainer2/HBoxContainer/LapContainer/LapsSelect.value

	ApplyCustomization.laps = laps
	SceneSwitcher.selected_track = track
	
	SceneSwitcher.begin_race()

func _on_Customise_pressed():
	SceneSwitcher.customise_player()


func _on_Quit_pressed():
	get_tree().quit()


func _on_TrackSelect_item_selected(ID):
	if ID == 0:
		$VBoxContainer2/TextureRect.texture = load("res://scenes/Tracks/maps/loop.PNG")
	elif ID == 1:
		$VBoxContainer2/TextureRect.texture = load("res://scenes/Tracks/maps/winding.PNG")
	else:
		$VBoxContainer2/TextureRect.texture = load("res://scenes/Tracks/maps/doublecross.PNG")
