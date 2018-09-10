extends Spatial

var rotation_speed = 1.0
var current_cart_material_number = 1
var current_player_material_number = 2
var max_material_number

var materials

export var target_rotation_speed = 1
export var max_rotation_speed = 10
export var rotation_speed_step = 0.025


func _ready():
	materials = $Materials.materials
	max_material_number = materials.size()
	_on_RandomizeButton_pressed()


func _physics_process(delta):
	$Cart.rotation +=  Vector3(0,1,0) * rotation_speed * delta
	rotation_speed = clamp(rotation_speed, -max_rotation_speed, max_rotation_speed)
	rotation_speed = lerp(rotation_speed, target_rotation_speed, rotation_speed_step)


func _input(event):
	if event is InputEventMouseMotion and Input.is_action_pressed("ui_select"):
		if event.speed.x < -0.5:
			rotation_speed -= 1
		elif event.speed.x > 0.5:
			rotation_speed += 1



func recolour():
	$Cart/MeshInstance.set_surface_material(3, load(materials[current_cart_material_number]))
	$Cart/MeshInstance.set_surface_material(4, load(materials[current_cart_material_number]))
	$Cart/MeshInstance.set_surface_material(1, load(materials[current_player_material_number]))


func _on_StartRaceButton_pressed():
	ApplyCustomization.Cart_material = materials[current_cart_material_number]
	ApplyCustomization.Player_material = materials[current_player_material_number]
	get_tree().change_scene("res://scenes/Track1.tscn")


func _on_CartButtonLeft_pressed():
	if current_cart_material_number > 1:
		current_cart_material_number -= 1
	else:
		current_cart_material_number = max_material_number
	recolour()


func _on_CartButtonRight_pressed():
	if current_cart_material_number < max_material_number:
		current_cart_material_number += 1
	else:
		current_cart_material_number = 1
	recolour()


func _on_SuitButtonLeft_pressed():
	if current_player_material_number > 1:
		current_player_material_number -= 1
	else:
		current_player_material_number = max_material_number
	recolour()


func _on_SuitButtonRight_pressed():
	if current_player_material_number < max_material_number:
		current_player_material_number += 1
	else:
		current_player_material_number = 1
	recolour()


func _on_RandomizeButton_pressed():
	randomize()
	current_cart_material_number = randi() % max_material_number +1
	current_player_material_number = randi() % max_material_number +1
	recolour()
