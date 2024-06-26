extends CharacterBody2D

var in_detection = false
@export var items : Array[Item]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")
	$Talk.hide()
	Dialogic.signal_event.connect(open_shop)

func _physics_process(delta):
	if in_detection == true and Global.inDialog == false:
		if Input.is_action_just_pressed("interact"):
			UI.open_mode(UI.MODE.SHOP, items)
			$Talk.hide()
			Global.inDialog = true
			#Dialogic.start("Eleonore Test")
			#Dialogic.timeline_ended.connect(_on_timeline_ended)

func open_shop(argument:String):
	if argument == "shop":
		UI.open_mode(UI.MODE.SHOP, Item)

func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Global.inDialog = false
	Global.inDialog = false
	$Talk.show()

func _on_detectionarea_body_entered(body):
	if body.has_method("player"):
		in_detection = true
		$Talk.show()


func _on_detectionarea_body_exited(body):
	if body.has_method("player"):
		in_detection = false
		$Talk.hide()

