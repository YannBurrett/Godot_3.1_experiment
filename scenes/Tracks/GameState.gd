extends Spatial

export var lap_target = 2

var lap_tracker = {}

func track_lap(player, lap):
	lap_tracker[player] = lap
	if lap_tracker[player] == lap_target:
		print(str(player) + " wins!" )
	else:
		print("closer!")