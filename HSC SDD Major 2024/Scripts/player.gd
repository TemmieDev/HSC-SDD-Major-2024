extends CharacterBody2D

var player_data = PlayerData.new()
var speed = 100
var current_dir = "none"
var stamina = 3
var running = false
var walking = false
@onready var stamina_bar = $"AnimatedSprite2D/Stamina Bar"
@onready var tilemap

var area : String = "": 
	set(value): 
		area = value
		%Tile.text = value

var step_size : int = 7

var distance_in_pixel: float = 0.0:
	set(value):
		distance_in_pixel = value
		var step = distance_in_pixel / step_size
		
		%Distance.text = "%d" % step
		
		if step >= Manager.encounter_number and Global.encounter == true:
			$"../HUD/AnimationPlayer".play("TransIn")
			$"../HUD/SFX".play()
			Global.inBattle = true
			Manager.change_scene()
			distance_in_pixel = 0.0
			Manager.encounterNum()
			await get_tree().create_timer(1).timeout
			$"../HUD/AnimationPlayer".play("TransOut")

func _ready():
	$AnimatedSprite2D.play("down_idle")
	stamina_bar.hide()
	
func _physics_process(delta):
	Manager.playerArea = area
	var initial_position = position
	update_tile()
	if Global.inDialog == false:
		player_movement(delta)
	distance_in_pixel += position.distance_to(initial_position)
	run(delta)
	if Input.is_action_pressed("run") and walking == true:
		running = true
	else:
		running = false
	stamina_bar.value = stamina
	Global.player_pos = self.position
	if Global.cur_location == "Dungeon":
		tilemap = get_tree().current_scene.find_child("TileMap")


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

func update_tile():
	if Global.cur_location == "Dungeon":
		await get_tree().create_timer(0.1).timeout
		var tiledata = tilemap.get_cell_tile_data(0, tilemap.local_to_map(position))
		if tiledata:
			area = tiledata.get_custom_data("Area")


