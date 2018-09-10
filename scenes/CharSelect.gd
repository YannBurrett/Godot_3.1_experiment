extends Spatial

var rotation_speed = 1.0
var P1_current_cart_material_number = 1
var P1_current_player_material_number = 2
var P2_current_cart_material_number = 1
var P2_current_player_material_number = 2
var max_material_number

var materials

export var target_rotation_speed = 1
export var max_rotation_speed = 10
export var rotation_speed_step = 0.025


func _ready():
	materials = $Materials.materials
	max_material_number = materials.size()
	_on_Randomise_pressed(1)
	_on_Randomise_pressed(2)


func _physics_process(delta):
	$Cart1.rotation +=  Vector3(0,1,0) * rotation_speed * delta
	$Cart2.rotation +=  Vector3(0,1,0) * -rotation_speed * delta
	rotation_speed = clamp(rotation_speed, -max_rotation_speed, max_rotation_speed)
	rotation_speed = lerp(rotation_speed, target_rotation_speed, rotation_speed_step)


#func _input(event):
#	if event is InputEventMouseMotion and Input.is_action_pressed("ui_select"):
#		if event.speed.x < -0.5:
#			rotation_speed -= 1
#		elif event.speed.x > 0.5:
#			rotation_speed += 1



func recolour():
	$Cart1/MeshInstance.set_surface_material(3, load(materials[P1_current_cart_material_number]))
	$Cart1/MeshInstance.set_surface_material(4, load(materials[P1_current_cart_material_number]))
	$Cart1/MeshInstance.set_surface_material(1, load(materials[P1_current_player_material_number]))
	$Cart2/MeshInstance.set_surface_material(3, load(materials[P2_current_cart_material_number]))
	$Cart2/MeshInstance.set_surface_material(4, load(materials[P2_current_cart_material_number]))
	$Cart2/MeshInstance.set_surface_material(1, load(materials[P2_current_player_material_number]))


func _on_CartButtonLeft_pressed(player):
	if player ==1:
		if P1_current_cart_material_number > 1:
			P1_current_cart_material_number -= 1
		else:
			P1_current_cart_material_number = max_material_number
	else:
		if P2_current_cart_material_number > 1:
			P2_current_cart_material_number -= 1
		else:
			P2_current_cart_material_number = max_material_number
		
	recolour()


func _on_CartButtonRight_pressed(player):
	if player == 1:
		if P1_current_cart_material_number < 1:
			P1_current_cart_material_number += 1
		else:
			P1_current_cart_material_number = 1
	else:
		if P2_current_cart_material_number < 1:
			P2_current_cart_material_number += 1
		else:
			P2_current_cart_material_number = 1
			
	recolour()


func _on_SuitButtonLeft_pressed(player):
	if player == 1:
		if P1_current_player_material_number > 1:
			P1_current_player_material_number -= 1
		else:
			P1_current_player_material_number = max_material_number
	else:
		if P2_current_player_material_number > 1:
			P2_current_player_material_number -= 1
		else:
			P2_current_player_material_number = max_material_number
	recolour()


func _on_SuitButtonRight_pressed(player):
	if player == 1:
		if P1_current_player_material_number < max_material_number:
			P1_current_player_material_number += 1
		else:
			P1_current_player_material_number = 1
	else:
		if P2_current_player_material_number < max_material_number:
			P2_current_player_material_number += 1
		else:
			P2_current_player_material_number = 1
	recolour()


func _on_Randomise_pressed(player):
	randomize()
	if player == 1:
		P1_current_cart_material_number = randi() % max_material_number +1
		P1_current_player_material_number = randi() % max_material_number +1
	else:
		P2_current_cart_material_number = randi() % max_material_number +1
		P2_current_player_material_number = randi() % max_material_number +1
	recolour()


func _on_Begin_pressed():
	ApplyCustomization.Player1_Cart_material = materials[P1_current_cart_material_number]
	ApplyCustomization.Player2_Cart_material = materials[P2_current_cart_material_number]
	ApplyCustomization.Player1_Player_material = materials[P1_current_player_material_number]
	ApplyCustomization.Player2_Player_material = materials[P2_current_player_material_number]
	get_tree().change_scene("res://scenes/SplitScreen.tscn")
#	get_tree().change_scene("res://scenes/Track1.tscn")
