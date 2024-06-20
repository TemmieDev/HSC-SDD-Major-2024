extends CanvasLayer

func startbattle():
	$AnimationPlayer.play("TransIn")
	$SFX.play()
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("TransOut")

func _on_button_3_pressed():
	SaveLoad.run_save()


func _on_button_2_pressed():
	SaveLoad.run_load()
