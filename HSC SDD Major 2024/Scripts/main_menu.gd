extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/Main.show()
	$CanvasLayer/Options.hide()
	$CanvasLayer/Help.hide()
	Global.inMenu = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	Global.player_cur_hp = Global.player_max_hp
	Global.player_cur_mana = Global.player_max_mana
	Global.inMenu = false
	SceneChanger.switch_scene("res://Scenes/Base.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_options_pressed():
	$CanvasLayer/Main.hide()
	$CanvasLayer/Options.show()


func _on_back_pressed():
	$CanvasLayer/Main.show()
	$CanvasLayer/Options.hide()


func _on_back_2_pressed():
	$CanvasLayer/Main.show()
	$CanvasLayer/Help.hide()


func _on_help_pressed():
	$CanvasLayer/Main.hide()
	$CanvasLayer/Help.show()
