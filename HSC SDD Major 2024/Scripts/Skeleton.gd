extends CharacterBody2D

var speed = 80
var player_chase = false
var player = null
var battle = preload("res://Scenes/battle_scene.tscn")

func _ready():
	$AnimatedSprite2D2.hide()

func _physics_process(delta):
	if player_chase == true:
		position += (player.position - position).normalized() * speed * delta
		move_and_collide(Vector2(0,0))  
		$AnimatedSprite2D.play("side_walk")
		
		if player.position.x - position.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("side_idle")
		velocity = lerp(velocity, Vector2.ZERO, 0.07)
	move_and_collide(velocity)

func _on_detection_area_body_entered(body):
	speed = 80
	player = body
	player_chase = true


func _on_detection_area_body_exited(body):
	speed = 60


func _on_detection_area_2_body_entered(body):
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D2.show()
	await get_tree().create_timer(0.5).timeout
	$AnimatedSprite2D2.hide()
	speed = 80
	player = body
	player_chase = true


func _on_detection_area_2_body_exited(body):
	player = null
	player_chase = false


func _on_battle_detection_body_entered(body):
	if player:
		SaveLoad.run_save()
		Global.enemy = "Skeleton"
		$"../HUD/AnimationPlayer".play("TransIn")
		$"../HUD/SFX".play()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/battle_scene.tscn")
		queue_free()
