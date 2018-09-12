extends Area



func _on_Checkpoint_body_entered(body):
	$AudioStreamPlayer3D.play()
