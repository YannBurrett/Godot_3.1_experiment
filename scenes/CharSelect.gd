extends Spatial

var rotation_speed = 1.0
var max_material_number
var current_cart_material_number = {1: 1, 2: 1}
var current_player_material_number = {1: 1, 2: 1}

var materials


export var rotation_speed_step = 0.025


func _ready():
	materials = $Materials.materials
	max_material_number = materials.size()
	print(max_material_number)
	_on_Randomise_pressed(1)
	_on_Randomise_pressed(2)


func _physics_process(delta):
	$Cart1.rotation +=  Vector3(0,1,0) * rotation_speed * delta
	$Cart2.rotation +=  Vector3(0,1,0) * -rotation_speed * delta


func recolour():
	var cart = 4
	var helmet = 3
	var suit = 1
	
	$Cart1/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[1]]))
	$Cart1/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[1]]))
	$Cart1/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[1]]))

	$Cart2/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[2]]))
	$Cart2/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[2]]))
	$Cart2/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[2]]))



func _on_CartButtonLeft_pressed(player):
	if current_cart_material_number[player] >1:
		current_cart_material_number[player] -=1
	else:
		current_cart_material_number[player] = max_material_number

	recolour()


func _on_CartButtonRight_pressed(player):
	if current_cart_material_number[player] < max_material_number:
		current_cart_material_number[player] +=1
	else:
		current_cart_material_number[player] = 1
	print(current_cart_material_number[player])

	recolour()


func _on_SuitButtonLeft_pressed(player):
	if current_player_material_number[player] >1:
		current_player_material_number[player] -=1
	else:
		current_player_material_number[player] = max_material_number
	recolour()


func _on_SuitButtonRight_pressed(player):
	if current_player_material_number[player] < max_material_number:
		current_player_material_number[player] +=1
	else:
		current_player_material_number[player] = 1
	recolour()


func _on_Randomise_pressed(player):
	randomize()
	current_cart_material_number[player] = randi() % max_material_number +1
	current_player_material_number[player] = randi() % max_material_number +1
	recolour()


func _on_Begin_pressed():
	ApplyCustomization.Player_material[1] = materials[current_player_material_number[1]]
	ApplyCustomization.Player_material[2] = materials[current_player_material_number[2]]
	ApplyCustomization.Cart_material[1] = materials[current_cart_material_number[1]]
	ApplyCustomization.Cart_material[2] = materials[current_cart_material_number[2]]
	get_tree().change_scene("res://scenes/SplitScreen.tscn")
#	get_tree().change_scene("res://scenes/Track1.tscn")