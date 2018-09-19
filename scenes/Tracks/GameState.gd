extends Spatial

var lap_target

var lap_tracker = {}
var total_checkpoints

var race_won = false


func _ready():
	count_checkpoints()
	lap_target = ApplyCustomization.laps
	$CSGWalls/InnerWall/CSGPolygon.set_collision_layer(2)


func count_checkpoints():
	total_checkpoints = $Checkpoints.get_child_count()
	get_tree().call_group("players", "update_checkpoints", total_checkpoints)


func track_lap(player, lap):
	lap_tracker[player] = lap
	if lap_tracker[player] == lap_target:
		win(player)


func win(player):
	if race_won == false:
		get_tree().call_group("players", "win", player)
		$Timer.start()
	race_won = true


func _on_Timer_timeout():
	BGMplayer.stream = load("res://SFX/Juhani Junkala [Retro Game Music Pack] Title Screen.wav")
	BGMplayer.play()
	SceneSwitcher.pick_track()
