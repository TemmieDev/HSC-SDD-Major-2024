extends Node2D

var inArea : bool = false

func _ready():
	$Enter.hide()
	Global.inMenu = false
	inArea = false
	if Global.newPlayer == true:
		Global.levelup()
		Dialogic.start("NewPlayer")
		Global.inDialog = true
		Dialogic.timeline_ended.connect(_on_timeline_ended)
	Global.newPlayer = false
	
	


func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Global.inDialog = false


func _on_area_2d_body_entered(body):
	$Enter.show()
	inArea = true

func _on_area_2d_body_exited(body):
	$Enter.hide()
	inArea = false

func _physics_process(delta):
	if Input.is_action_just_pressed("interact") and inArea == true and Global.inDialog == false:
		SceneChanger.switch_scene("res://Scenes/dungeon.tscn")
