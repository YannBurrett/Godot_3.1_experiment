extends Node

onready var start = "res://scenes/PlayerSelection/PlayerPicker.tscn"
onready var customisation = "res://scenes/ChararcterCustomisation/SplitCustomization.tscn"
onready var track_selection = "res://scenes/Tracks/TrackSelector.tscn"


onready var tracks_list ={0: "res://scenes/Tracks/TrackLoop.tscn", 1: "res://scenes/Tracks/TrackWinding.tscn", 2:"res://scenes/Tracks/TrackDoubleCross.tscn"}
var selected_track
var track

func _ready():
	pick_players()


func pick_players():
	get_tree().change_scene(start)


func customise_player():
	get_tree().change_scene(customisation)


func pick_track():
	get_tree().change_scene(track_selection)
	
func begin_race():
	track = tracks_list[selected_track]
	get_tree().change_scene(track)