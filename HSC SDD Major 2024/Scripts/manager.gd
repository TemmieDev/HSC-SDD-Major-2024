extends Node2D

var battle : PackedScene = load("res://Scenes/battle_scene.tscn")
var playerArea


var encounter_number : int = 100:
	set(value):
		encounter_number = value
		%Encounter.text = str(value)

var grassEnemies = [
	"Skeleton"
]

var dungeonEnemies = [
	"Skeleton", "Orc"
]


func _ready():
	encounterNum()

func change_scene():
	var enemy
	if playerArea == "Grassland":
		enemy = grassEnemies.pick_random()
	elif playerArea == "Dungeon":
		enemy = dungeonEnemies.pick_random()
	else:
		enemy = grassEnemies.pick_random()
	Global.enemy = enemy
	get_tree().paused = true
	await get_tree().create_timer(1).timeout
	var battleTemp = battle.instantiate()
	get_parent().add_child(battleTemp)

func encounterNum():
	randomize()
	encounter_number = randi_range(50,150)

func _physics_process(delta):
	var fps = Engine.get_frames_per_second()
	%FPS.text = str("FPS: ", fps )
