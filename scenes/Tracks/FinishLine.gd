extends Spatial

func _on_FinishLine_body_entered(body):
	body.add_lap()
