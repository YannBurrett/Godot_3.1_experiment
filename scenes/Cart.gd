extends VehicleBody

export var player_id = 1

var respawn_point
var last_checkpoint = 0
var total_checkpoints
var lap = 0

############################################################
# behaviour values

export var MAX_ENGINE_FORCE = 50
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0
var steer_direction = 1

############################################################
# Input

export var steering_mult = -1.0
export var throttle_mult = 1.0
export var brake_mult = 1.0

func _ready():
	respawn_point = translation
	if player_id > ApplyCustomization.player_count:
		call_deferred("queue_free")
	apply_custom_colour()


func apply_custom_colour():
	var cart = 4
	var helmet = 3
	var suit = 1

	$MeshInstance.set_surface_material(cart, load(ApplyCustomization.Cart_material[player_id]))
	$MeshInstance.set_surface_material(helmet, load(ApplyCustomization.Cart_material[player_id]))
	$MeshInstance.set_surface_material(suit, load(ApplyCustomization.Player_material[player_id]))
	$MeshInstance/FlagPole/Flag.material_override = load(ApplyCustomization.Decal_material[player_id])


func _physics_process(delta):
	var steer_val = steering_mult * Input.get_action_strength("right_%s" % player_id)
	var throttle_val = throttle_mult * Input.get_action_strength("up_%s" % player_id)
	var brake_val = brake_mult * Input.get_action_strength("brake_%s" % player_id)
	
	# overides for keyboard
	if Input.get_action_strength("up_%s" % player_id):
		throttle_val = 1.0
	if Input.get_action_strength("back_%s" % player_id):
		throttle_val = -1.0
	if Input.get_action_strength("brake_%s" % player_id):
		brake_val = 1.0
	if Input.get_action_strength("left_%s" % player_id):
		steer_val = 1.0
	elif Input.get_action_strength("right_%s" % player_id):
		steer_val = -1.0
	
	if Input.is_action_just_released("reset_position_%s" % player_id):
		respawn()
	
	engine_force = throttle_val * MAX_ENGINE_FORCE
	brake = brake_val * MAX_BRAKE_FORCE
	
	steer_target = steer_val * MAX_STEER_ANGLE
	if (steer_target < steer_angle):
		steer_angle -= steer_speed * delta
		if (steer_target > steer_angle):
			steer_angle = steer_target 
	elif (steer_target > steer_angle):
		steer_angle += steer_speed * delta
		if (steer_target < steer_angle):
			steer_angle = steer_target
	
	steering = steer_angle * steer_direction

	if throttle_val >0.1:
		if not $EngineSound.is_playing():
			$EngineSound.play()
	else:
		$EngineSound.stop()

	if translation.y <0:
		respawn()


func lock():
	axis_lock_angular_y = true
	axis_lock_linear_y = true


func unlock():
	axis_lock_angular_y = false
	axis_lock_linear_y = false


func respawn():
	translation = respawn_point


func update_checkpoints(checkpoints):
	total_checkpoints = checkpoints


func checkpoint(spawn_point, checkpoint_id):
	if checkpoint_id == last_checkpoint:
		pass
	elif checkpoint_id == (last_checkpoint +1):
		respawn_point = spawn_point
		last_checkpoint = checkpoint_id
		print("checkpoint " + str(checkpoint_id))
		$AnimationPlayer.play("checkpoint")
	else:
		respawn()


func add_lap():
	if last_checkpoint == total_checkpoints:
		lap += 1
		last_checkpoint = 0
		get_tree().call_group("gamestate", "track_lap", player_id, lap)
		$CheckpointParticles.emitting = true
		print(player_id)
		print(lap)
	elif last_checkpoint == 0:
		pass
	else: respawn()


func win(player):
	if player == player_id:
		get_tree().call_group("victory", "win", player_id)


func pickup():
	var reverser = load("res://scenes/Pickups/Reverser.tscn")
	var reverserobject = reverser.instance()
	add_child(reverserobject)
	$Popup.popup_centered()
	$Popup/Timer.start()
	

func _on_Timer_timeout():
	steer_direction = 1
	$Popup.hide()
