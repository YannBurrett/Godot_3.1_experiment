extends Spatial

var lap_target

var lap_tracker = {}
var total_checkpoints


func _ready():
	count_checkpoints()
	lap_target = ApplyCustomization.laps


func count_checkpoints():
	total_checkpoints = $Checkpoints.get_child_count()
	get_tree().call_group("players", "update_checkpoints", total_checkpoints)


func track_lap(player, lap):
	lap_tracker[player] = lap
	if lap_tracker[player] == lap_target:
		win(player)


func win(player):
	print(player)
	get_tree().call_group("players", "win", player)
	$Timer.start()
	


func _on_Timer_timeout():
	BGMplayer.stream = load("res://SFX/Juhani Junkala [Retro Game Music Pack] Title Screen.wav")
	BGMplayer.play()
	SceneSwitcher.pick_track()
