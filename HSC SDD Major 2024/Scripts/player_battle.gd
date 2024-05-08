extends Node2D
class_name Character

@export var is_player : bool
@export var cur_hp : int = 25
@export var max_hp : int = 25

@export var combat_action : Array
@export var opponent : Node

@onready var health_bar : ProgressBar = get_node("HealthBar")
@onready var health_text : Label = get_node("HealthBar/Label")

@export var visual : Texture2D
@export var flip_visual : bool

func _ready():
	$Sprite2D.texture = visual
	$Sprite2D.flip_h = flip_visual
	
	get_node("/root/BattleScene").character_begin_turn.connect(_on_character_begin_turn)
	health_bar.max_value = max_hp

func _take_damage(damage):
	cur_hp -= damage
	_update_health_bar()
	
	if cur_hp <= 0:
		get_node("/root/BattleScene").character_died(self)
		queue_free()

func heal (amount):
	cur_hp += amount
	
	if cur_hp > max_hp:
		cur_hp = max_hp
	
	_update_health_bar()

func _update_health_bar ():
	health_bar.value = cur_hp
	health_text.text = str(cur_hp, "/", max_hp)

func _on_character_begin_turn(character):
	pass
