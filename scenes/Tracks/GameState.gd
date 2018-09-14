extends Spatial

export var lap_target = 1

var lap_tracker = {}
var total_checkpoints


func _ready():
	count_checkpoints()


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
