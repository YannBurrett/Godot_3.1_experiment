extends Spatial

var lap_target

var lap_tracker = {0:0, 1:0, 2:0, 3:0, 4:0}
var total_checkpoints

var race_won = false

var offsets = {}


func _ready():
	count_checkpoints()
	lap_target = ApplyCustomization.laps


func update_placement(player, offset):
	offsets[player] = offset
	var my_place = 1
	for i in offsets:
		if not offsets[i] == 0 and not i == player:
			if offsets[i] > offsets[player]:
				my_place += 1
	return my_place

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
	BGMplayer.menu_music()
	SceneSwitcher.pick_track()
