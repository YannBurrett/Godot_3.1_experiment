extends Spatial

func _on_FinishLine_body_entered(body):
	if body.has_method("add_lap"):
		body.add_lap()
