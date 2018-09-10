extends Control

onready var view1 = $HBoxContainer/ViewportContainer1/Viewport
onready var view2 = $HBoxContainer/ViewportContainer2/Viewport
onready var camera1 = $HBoxContainer/ViewportContainer1/Viewport/Camera1
onready var track = $HBoxContainer/ViewportContainer1/Viewport/Track1

func _ready():
	view2.world = view1
	
