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
var stored_engine_force

############################################################
# Input


func _ready():
	call_deferred("respawn_point = translation")
	if player_id > ApplyCustomization.player_count:
		call_deferred("queue_free")
	apply_custom_colour()
	$CheckpointParticles/ThoughtBubble.hide()
	add_lap()
	respawn_point = translation


func apply_custom_colour():
	var cart = 4
	var underside = 6
	var helmet = 3
	var suit = 1

	$MeshInstance.set_surface_material(cart, load(ApplyCustomization.Cart_material[player_id]))
	$MeshInstance.set_surface_material(underside, load(ApplyCustomization.Cart_material[player_id]))
	$MeshInstance.set_surface_material(helmet, load(ApplyCustomization.Cart_material[player_id]))
	$MeshInstance.set_surface_material(suit, load(ApplyCustomization.Player_material[player_id]))
	$MeshInstance/FlagPole/Flag.material_override = load(ApplyCustomization.Decal_material[player_id])


func _physics_process(delta):
	var steer_val = 0
	var throttle_val = 0 
	var brake_val = 0
	
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
	stored_engine_force = MAX_ENGINE_FORCE
	MAX_ENGINE_FORCE = 0


func unlock():
	MAX_ENGINE_FORCE = stored_engine_force


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
		$AnimationPlayer.play("checkpoint")
	else:
		respawn()


func add_lap():
	if last_checkpoint == total_checkpoints:
		lap += 1
		last_checkpoint = 0
		$CheckpointParticles.emitting = true
	elif last_checkpoint == 0:
		pass
	else: respawn()
	get_tree().call_group("gamestate", "track_lap", player_id, lap)


func win(player):
	lock()
	if player == player_id:
		get_tree().call_group("victory", "win", player_id)


func pickup_reverser():
	var reverser = load("res://scenes/Pickups/Reverser.tscn")
	var reverserobject = reverser.instance()
	add_child(reverserobject)




