extends AudioStreamPlayer


func _ready():
	get_tree().call_group("players", "lock")



func unlock():
		get_tree().call_group("players", "unlock")
		queue_free()
