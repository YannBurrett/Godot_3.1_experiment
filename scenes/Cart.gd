extends VehicleBody

export (NodePath) var path = null
export var player_id = 1

var respawn_point
var last_checkpoint = 0
var total_checkpoints
var lap = 0

var my_position = 1
var my_last_position = 1

#var star = preload("res://textures/star_emoji.material")

############################################################
# behaviour values

export var MAX_ENGINE_FORCE = 50
export var MAX_BRAKE_FORCE = 5.0
export var MAX_STEER_ANGLE = 0.5

export var steer_speed = 5

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
	$ThoughtBubble.hide()
	add_lap()
	respawn_point = translation
	create_position_timer()



func create_position_timer():
	var timer = Timer.new()
	timer.connect("timeout",self,"get_placement")
	timer.wait_time = 0.5
	add_child(timer)
	timer.start()


############################################################
# Path info

func get_offset_from_starting_line():
	if path:
		var p = get_node(path)
		
		# get our carts position in the paths local space
		var pos = p.global_transform.xform_inv(global_transform.origin)
		
		# get our curve
		var c = p.curve
		
		# and our offset
		var offset = c.get_closest_offset(pos)
		
		# we need to add a protection when we're nearing the finish line that we don't cycle around to 0 before we cross it
		var lap_offset = lap * 1000
		return stepify((offset + lap_offset), 2)
	else:
		return 0


func apply_custom_colour():
	var cart = 2
	var helmet = 1
	var suit = 0

	$MeshInstance.set_surface_material(cart, load(ApplyCustomization.Cart_material[player_id]))
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
	
	if Input.is_action_just_released("horn_%s" % player_id) and not $Horn.is_playing():
		$Horn.play()
	
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
	else:
		respawn()


func add_lap():
	if last_checkpoint == total_checkpoints:
		lap += 1
		last_checkpoint = 0
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

func get_placement():
	var my_offset = get_offset_from_starting_line()
	my_position = get_node("..").update_placement(player_id, my_offset)
	if not my_position == my_last_position:
		if my_position < my_last_position:
			be_happy()
		elif my_position > my_last_position:
			be_sad()
		my_last_position = my_position
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("show_emotion")
		get_tree().call_group("gamestate", "placement", player_id, my_position)


func be_happy():
	$ThoughtBubble.be_happy()


func be_sad():
	$ThoughtBubble.be_sad()