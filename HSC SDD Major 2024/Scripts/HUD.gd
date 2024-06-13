extends CanvasLayer


func _on_button_pressed():
	get_tree().quit()


func _on_button_3_pressed():
	SaveLoad.run_save()


func _on_button_2_pressed():
	SaveLoad.run_load()
