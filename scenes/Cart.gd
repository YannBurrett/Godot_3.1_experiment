extends VehicleBody

export var player_id = 1

var respawn_point
var last_checkpoint = 1

############################################################
# behaviour values

export var MAX_ENGINE_FORCE = 50
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5.0

var steer_target = 0.0
var steer_angle = 0.0

############################################################
# Input

export var joy_steering = JOY_ANALOG_LX
export var steering_mult = -1.0
export var joy_throttle = JOY_ANALOG_R2
export var throttle_mult = 1.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

func _ready():
	respawn_point = translation
	if player_id > ApplyCustomization.player_count:
		queue_free()
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
	var steer_val = steering_mult * Input.get_joy_axis(0, joy_steering)
	var throttle_val = throttle_mult * Input.get_joy_axis(0, joy_throttle)
	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
	
	# ovverides for keyboard
	if Input.is_action_pressed("up_%s" % player_id):
		throttle_val = 1.0
	if Input.is_action_pressed("back_%s" % player_id):
		throttle_val = -1.0
	if Input.is_action_pressed("brake_%s" % player_id):
		brake_val = 1.0
	if Input.is_action_pressed("left_%s" % player_id):
		steer_val = 1.0
	elif Input.is_action_pressed("right_%s" % player_id):
		steer_val = -1.0
	
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
	
	steering = steer_angle

	if throttle_val >0.1:
		if not $EngineSound.is_playing():
			$EngineSound.play()
	else:
		$EngineSound.stop()

	if translation.y <0:
		respawn()
		

func respawn():
	translation = respawn_point


func checkpoint(spawn_point, checkpoint_id):
	if checkpoint_id < last_checkpoint:
		print("wrong way!")
	else:
		respawn_point = spawn_point
		last_checkpoint = checkpoint_id
		print("checkpoint " + str(checkpoint_id))
		$CheckpointParticles.emitting = true
		$CheckpointParticles/AudioStreamPlayer3D.play()
