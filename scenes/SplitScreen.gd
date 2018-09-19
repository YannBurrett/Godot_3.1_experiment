extends Control


func _ready():
	var view1 = $Splitter/ViewportContainer1/Viewport
	var view2 = $Splitter/ViewportContainer2/Viewport
	var view3 = $Splitter/ViewportContainer3/Viewport
	var view4 = $Splitter/ViewportContainer4/Viewport

	
	view2.world = view1
	view3.world = view1
	view4.world = view1
	
	BGMplayer.race_music()
	update_player_count()


func update_player_count():
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
