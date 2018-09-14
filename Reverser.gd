extends Node

var driver

func _ready():
	driver = get_parent()
	driver.steer_direction = -1
	$Timer.start()

func _on_Timer_timeout():
	driver.steer_direction = 1
	queue_free()
