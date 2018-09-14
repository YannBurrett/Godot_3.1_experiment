extends Control



func _on_Race_Button_pressed():
	var track = $HBoxContainer/TrackContainer/TrackSelect.selected
	var laps = $HBoxContainer/LapContainer/LapsSelect.value

	ApplyCustomization.laps = laps
	SceneSwitcher.selected_track = track
	
	SceneSwitcher.begin_race()

func _on_Customise_pressed():
	SceneSwitcher.customise_player()


func _on_Quit_pressed():
	get_tree().quit()
