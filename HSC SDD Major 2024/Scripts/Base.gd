extends Node2D

var inArea : bool = false

func _ready():
	$Enter.hide()
	Global.inMenu = false
	inArea = false
	Global.levelup()

func _on_area_2d_body_entered(body):
	$Enter.show()
	inArea = true

func _on_area_2d_body_exited(body):
	$Enter.hide()
	inArea = false

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and inArea == true:
		SceneChanger.switch_scene("res://Scenes/dungeon.tscn")
