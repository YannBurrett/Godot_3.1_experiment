extends Control


func _ready():
	var view1 = $Splitter/ViewportContainer1/Viewport
	var view2 = $Splitter/ViewportContainer2/Viewport
	var view3 = $Splitter/ViewportContainer3/Viewport
	var view4 = $Splitter/ViewportContainer4/Viewport
#warning-ignore:unused_variable
	var camera1 = $Splitter/ViewportContainer3/Viewport
#warning-ignore:unused_variable
	var track = $Splitter/ViewportContainer4/Viewport
	
	view2.world = view1
	view3.world = view1
	view4.world = view1
	
	BGMplayer.stop()
	BGMplayer.stream = load("res://SFX/Juhani Junkala [Retro Game Music Pack] Level 2.wav")
	BGMplayer.play()
	update_player_count()


func update_player_count():
	var name1 = $Splitter/ViewportContainer1/Name1
	var name2 = $Splitter/ViewportContainer2/Name2
	var name3 = $Splitter/ViewportContainer3/Name3
	var name4 = $Splitter/ViewportContainer4/Name4
	
	name1.text = ApplyCustomization.Player_names[1]
	name2.text = ApplyCustomization.Player_names[2]
	name3.text = ApplyCustomization.Player_names[3]
	name4.text = ApplyCustomization.Player_names[4]
	if ApplyCustomization.player_count == 1:
		$Splitter/ViewportContainer2.hide()
		$Splitter/ViewportContainer3.hide()
		$Splitter/ViewportContainer4.hide()
		$Splitter/ViewportContainer2/Viewport/Camera2.cart_despawn()
		$Splitter/ViewportContainer3/Viewport/Camera3.cart_despawn()
		$Splitter/ViewportContainer4/Viewport/Camera4.cart_despawn()
	if ApplyCustomization.player_count == 2:
		$Splitter/ViewportContainer3.hide()
		$Splitter/ViewportContainer4.hide()
		$Splitter/ViewportContainer3/Viewport/Camera3.cart_despawn()
		$Splitter/ViewportContainer4/Viewport/Camera4.cart_despawn()
	if ApplyCustomization.player_count == 3:
		$Splitter/ViewportContainer4.hide()
		$Splitter/ViewportContainer4/Viewport/Camera4.cart_despawn()
