extends Node

var driver

#warning-ignore:unused_signal
signal timeout

func _ready():
	driver = get_parent()
	$Timer.start()
	driver.steer_direction = -1

#warning-ignore:unused_argument
func _process(delta):
	$TextureProgress.max_value = $Timer.wait_time
	$TextureProgress.value = $Timer.time_left


func _on_Timer_timeout():
	driver.steer_direction = 1
	queue_free()
