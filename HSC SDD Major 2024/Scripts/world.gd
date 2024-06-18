extends Node2D

var chest_detect = false
var talking = false

func _ready():
	SaveLoad.run_load()

func _physics_process(delta):
	if chest_detect == true and talking == false:
		if Input.is_action_pressed("interact"):
			Dialogic.start("Chest Interaction")
			talking = true
			Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	talking = false


func _on_chest_1_body_entered(body):
	if body.has_method("player"):
		chest_detect = true

func _on_chest_1_body_exited(body):
	if body.has_method("player"):
		chest_detect = false
		Dialogic.end_timeline()


func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		$HUD/AnimationPlayer.play("TransIn")
		$HUD/SFX.play()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/dungeon.tscn")
