extends Area

export var checkpoint_id = 1

func _on_Checkpoint_body_entered(body):
	body.checkpoint(translation, checkpoint_id)
