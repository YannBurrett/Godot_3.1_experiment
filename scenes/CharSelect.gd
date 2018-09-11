extends Spatial

var max_material_number
var current_cart_material_number = {1: 1, 2: 1, 3: 1, 4: 1}
var current_player_material_number = {1: 1, 2: 1, 3: 1, 4: 1}

var materials

func _ready():
	materials = $Materials.materials
	max_material_number = materials.size()
	update_player_view()
	_on_Randomise_pressed(1)
	_on_Randomise_pressed(2)
	_on_Randomise_pressed(3)
	_on_Randomise_pressed(4)


func update_player_view():
	var view2 = $VBoxContainer/GridContainer/View2
	var view3 = $VBoxContainer/GridContainer/View3
	var view4 = $VBoxContainer/GridContainer/View4
	if ApplyCustomization.player_count == 1:
		view2.hide()
		view3.hide()
		view4.hide()
	elif ApplyCustomization.player_count == 2:
		view3.hide()
		view4.hide()
	elif ApplyCustomization.player_count == 3:
		view4.hide()


func recolour():
	var cart = 4
	var helmet = 3
	var suit = 1
	
	$VBoxContainer/GridContainer/View1/Cart1/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[1]]))
	$VBoxContainer/GridContainer/View1/Cart1/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[1]]))
	$VBoxContainer/GridContainer/View1/Cart1/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[1]]))

	$VBoxContainer/GridContainer/View2/Cart2/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[2]]))
	$VBoxContainer/GridContainer/View2/Cart2/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[2]]))
	$VBoxContainer/GridContainer/View2/Cart2/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[2]]))

	$VBoxContainer/GridContainer/View3/Cart3/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[3]]))
	$VBoxContainer/GridContainer/View3/Cart3/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[3]]))
	$VBoxContainer/GridContainer/View3/Cart3/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[3]]))

	$VBoxContainer/GridContainer/View4/Cart4/MeshInstance.set_surface_material(helmet, load(materials[current_cart_material_number[4]]))
	$VBoxContainer/GridContainer/View4/Cart4/MeshInstance.set_surface_material(cart, load(materials[current_cart_material_number[4]]))
	$VBoxContainer/GridContainer/View4/Cart4/MeshInstance.set_surface_material(suit, load(materials[current_player_material_number[4]]))


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
	ApplyCustomization.Player_material[3] = materials[current_player_material_number[3]]
	ApplyCustomization.Player_material[4] = materials[current_player_material_number[4]]
	ApplyCustomization.Cart_material[1] = materials[current_cart_material_number[1]]
	ApplyCustomization.Cart_material[2] = materials[current_cart_material_number[2]]
	ApplyCustomization.Cart_material[3] = materials[current_cart_material_number[3]]
	ApplyCustomization.Cart_material[4] = materials[current_cart_material_number[4]]
	get_tree().change_scene("res://scenes/Tracks/SplitScreen.tscn")


func _on_Back_pressed():
	get_tree().change_scene("res://scenes/PlayerSelection/PlayerPicker.tscn")
