extends Popup

#warning-ignore:unused_argument
func _process(delta):
	if visible:
		$PowerIcon.max_value = $Timer.wait_time
		$PowerIcon.value = $Timer.time_left