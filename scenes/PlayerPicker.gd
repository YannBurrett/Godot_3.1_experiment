extends Control

func _ready():
	_on_HSlider_value_changed(1)
	


func _on_HSlider_value_changed(value):
	$CenterContainer/VBoxContainer/CenterContainer/GridContainer/Label.text = (str(value) + " players!")
