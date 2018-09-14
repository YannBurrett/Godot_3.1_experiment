extends Area



func _on_Pickup_body_entered(body):
	body.pickup()
	queue_free()
