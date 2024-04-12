extends CharacterBody2D

var in_detection = false
var talking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(delta):
	if in_detection == true and talking == false:
		if Input.is_action_pressed("interact"):
			Dialogic.start("Eleonore Test")
			talking = true
			Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	talking = false

func _on_detectionarea_body_entered(body):
	if body.has_method("player"):
		in_detection = true


func _on_detectionarea_body_exited(body):
	if body.has_method("player"):
		in_detection = false
		Dialogic.end_timeline()

