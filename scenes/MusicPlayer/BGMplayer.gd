extends AudioStreamPlayer

var menu = preload("res://SFX/Juhani Junkala [Retro Game Music Pack] Title Screen.wav")
var level_1_music = preload("res://SFX/Juhani Junkala [Retro Game Music Pack] Level 1.wav")
var level_2_music = preload("res://SFX/Juhani Junkala [Retro Game Music Pack] Level 2.wav")
var level_3_music = preload("res://SFX/Juhani Junkala [Retro Game Music Pack] Level 3.wav")

var jukebox = [level_1_music, level_2_music, level_3_music]

func _ready():
	menu_music()

func menu_music():
	stop()
	stream = menu
	play()

func race_music():
	randomize()
	var song = randi() % (jukebox.size())
	stop()
	stream = jukebox[song]
	play()