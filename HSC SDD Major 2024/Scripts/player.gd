extends CharacterBody2D

var player_data = PlayerData.new()
var speed = 100
var current_dir = "none"
var stamina = 3
var running = false
var walking = false
@onready var stamina_bar = $"AnimatedSprite2D/Stamina Bar"
@onready var health_bar = $"CanvasLayer/Health Bar"

func _ready():
	$AnimatedSprite2D.play("down_idle")
	stamina_bar.hide()
func _physics_process(delta):
	player_movement(delta)
	run(delta)
	if Input.is_action_pressed("run") and walking == true:
		running = true
	else:
		running = false
	stamina_bar.value = stamina
	health_bar.value = player_data.cur_hp
	health_bar.max_value = player_data.max_hp
	Global.player_pos = self.position

func player_movement(delta):
	if Input.is_action_pressed("move_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
		walking = true
	elif Input.is_action_pressed("move_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
		walking = true
	elif Input.is_action_pressed("move_down"):
		current_dir = "down"
		play_anim(1)
		velocity.x = 0
		velocity.y = speed
		walking = true
	elif Input.is_action_pressed("move_up"):
		current_dir = "up"
		play_anim(1)
		velocity.x = 0
		velocity.y = -speed
		walking = true
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		walking = false
	
	move_and_slide()

func run(delta):
	if running == true and stamina > 0:
		stamina -= delta
		speed = 150
		stamina_bar.show()
	else: 
		speed = 100

	if stamina <= 0:
		await get_tree().create_timer(2).timeout
		stamina += delta / 3
	elif stamina > 3:
		stamina = 3
	elif stamina == 3:
		stamina_bar.hide()
	
	if stamina < 3 and running == false:
		stamina += delta / 3
	

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("up_walk")
		elif movement == 0:
			anim.play("up_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("down_walk")
		elif movement == 0:
			anim.play("down_idle")

func player():
	pass
