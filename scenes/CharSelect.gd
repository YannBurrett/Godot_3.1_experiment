extends Spatial

var max_material_number
var max_decal_number
var current_cart_material_number = {1: 1, 2: 1, 3: 1, 4: 1}
var current_player_material_number = {1: 1, 2: 1, 3: 1, 4: 1}
var current_decal_number = {1: 1, 2: 1, 3: 1, 4: 1}

var materials
var decals

func _ready():
	update_materials_list()
	update_decal_list()
	update_player_view()
	_on_Randomise_pressed(1)
	_on_Randomise_pressed(2)
	_on_Randomise_pressed(3)
	_on_Randomise_pressed(4)


func update_materials_list():
	materials = $Materials.materials
	max_material_number = materials.size()


func update_decal_list():
	decals = $Materials.decals
	max_decal_number = decals.size()


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


func recolour(player):
	var cart = 4
	var helmet = 3
	var suit = 1
	
	var Cart = ("Carts/Cart%s"  %player +"/")
	
	get_node(Cart + "MeshInstance").set_surface_material(helmet, load(materials[current_cart_material_number[player]]))
	get_node(Cart + "MeshInstance").set_surface_material(cart, load(materials[current_cart_material_number[player]]))
	get_node(Cart + "MeshInstance").set_surface_material(suit, load(materials[current_player_material_number[player]]))
	get_node(Cart + "MeshInstance/FlagPole/Flag").material_override = (load(decals[current_decal_number[player]]))


func _on_CartButtonLeft_pressed(player):
	if current_cart_material_number[player] >1:
		current_cart_material_number[player] -=1
	else:
		current_cart_material_number[player] = max_material_number
	recolour(player)


func _on_CartButtonRight_pressed(player):
	if current_cart_material_number[player] < max_material_number:
		current_cart_material_number[player] +=1
	else:
		current_cart_material_number[player] = 1
	recolour(player)


func _on_SuitButtonLeft_pressed(player):
	if current_player_material_number[player] >1:
		current_player_material_number[player] -=1
	else:
		current_player_material_number[player] = max_material_number
	recolour(player)


func _on_SuitButtonRight_pressed(player):
	if current_player_material_number[player] < max_material_number:
		current_player_material_number[player] +=1
	else:
		current_player_material_number[player] = 1
	recolour(player)


func _on_DecalButtonLeft_pressed(player):
	if current_decal_number[player] >1:
		current_decal_number[player] -=1
	else:
		current_decal_number[player] = max_decal_number
	recolour(player)


func _on_DecalButtonRight_pressed(player):
	if current_decal_number[player] < max_decal_number:
		current_decal_number[player] +=1
	else:
		current_decal_number[player] = 1
	recolour(player)


func _on_Randomise_pressed(player):
	randomize()
	current_cart_material_number[player] = randi() % max_material_number +1
	current_player_material_number[player] = randi() % max_material_number +1
	current_decal_number[player] = randi() % max_decal_number +1
	recolour(player)


func _on_Begin_pressed():
	upload_colours()
	upload_decals()
	upload_names()
	get_tree().change_scene("res://scenes/Tracks/SplitScreen.tscn")


func upload_colours():
	ApplyCustomization.Player_material[1] = materials[current_player_material_number[1]]
	ApplyCustomization.Player_material[2] = materials[current_player_material_number[2]]
	ApplyCustomization.Player_material[3] = materials[current_player_material_number[3]]
	ApplyCustomization.Player_material[4] = materials[current_player_material_number[4]]
	ApplyCustomization.Cart_material[1] = materials[current_cart_material_number[1]]
	ApplyCustomization.Cart_material[2] = materials[current_cart_material_number[2]]
	ApplyCustomization.Cart_material[3] = materials[current_cart_material_number[3]]
	ApplyCustomization.Cart_material[4] = materials[current_cart_material_number[4]]


func upload_decals():
	ApplyCustomization.Decal_material[1] = decals[current_decal_number[1]]
	ApplyCustomization.Decal_material[2] = decals[current_decal_number[2]]
	ApplyCustomization.Decal_material[3] = decals[current_decal_number[3]]
	ApplyCustomization.Decal_material[4] = decals[current_decal_number[4]]


func upload_names():
	ApplyCustomization.Player_names[1] = $VBoxContainer/GridContainer/View1/CenterContainer/Name1.text
	ApplyCustomization.Player_names[2] = $VBoxContainer/GridContainer/View2/CenterContainer2/Name2.text
	ApplyCustomization.Player_names[3] = $VBoxContainer/GridContainer/View3/CenterContainer3/Name3.text
	ApplyCustomization.Player_names[4] = $VBoxContainer/GridContainer/View4/CenterContainer4/Name4.text

func _on_Back_pressed():
	get_tree().change_scene("res://scenes/PlayerSelection/PlayerPicker.tscn")



