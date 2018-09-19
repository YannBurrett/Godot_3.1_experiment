extends Node

onready var start = preload("res://scenes/PlayerSelection/PlayerPicker.tscn")
onready var customisation = preload("res://scenes/ChararcterCustomisation/SplitCustomization.tscn")
onready var track_selection = preload("res://scenes/Tracks/TrackSelector.tscn")


var tracks_list ={
		0: preload("res://scenes/Tracks/TrackLoop.tscn"), 
		1: preload("res://scenes/Tracks/TrackWinding.tscn"), 
		2: preload("res://scenes/Tracks/TrackDoubleCross.tscn")
		}
var selected_track
var track

func _ready():
	pick_players()


func pick_players():
#warning-ignore:return_value_discarded
	get_tree().change_scene_to(start)


func customise_player():
#warning-ignore:return_value_discarded
	get_tree().change_scene_to(customisation)


func pick_track():
#warning-ignore:return_value_discarded
	get_tree().change_scene_to(track_selection)
	
func begin_race():
	track = tracks_list[selected_track]
#warning-ignore:return_value_discarded
	get_tree().change_scene_to(track)