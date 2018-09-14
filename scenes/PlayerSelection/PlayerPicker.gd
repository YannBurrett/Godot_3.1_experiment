extends Control

var player_count

func _ready():
	_on_HSlider_value_changed(1)


func _on_HSlider_value_changed(value):
	$CenterContainer/VBoxContainer/CenterContainer/GridContainer/Label.text = (str(value) + " players!")
	update_windows(value)


func update_windows(value):
	if value == 1:
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer2.hide()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer3.hide()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer4.hide()
	elif value == 2:
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer2.show()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer3.hide()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer4.hide()
	elif value == 3:
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer2.show()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer3.show()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer4.hide()
	elif value == 4:
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer2.show()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer3.show()
		$CenterContainer/VBoxContainer/HBoxContainer/ViewportContainer4.show()
	player_count = value

func _on_BeginButton_pressed():
	ApplyCustomization.player_count = player_count
	SceneSwitcher.customise_player()
	
