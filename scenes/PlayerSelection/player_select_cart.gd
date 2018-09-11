extends VehicleBody

export var rotation_speed = 1

func _process(delta):
	rotation +=  Vector3(0,1,0) * rotation_speed * delta