extends Node2D

func _ready():
	Global.encounter = false
	if Dialogic.VAR.newPlayer == true:
		Dialogic.start("NewPlayer")
		Global.inDialog = true
		Dialogic.timeline_ended.connect(_on_timeline_ended)


func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Global.inDialog = false

