extends Node2D
class_name Character

#idea: Fire/heart icon that represents the potency of the move. Will update every player turn

@onready var battle_scene = get_node("../..")

var player_data = PlayerData.new()

@export var is_player : bool
@export var cur_hp : int = 15
@export var max_hp : int = 15
@export var cur_mana : int = 15
@export var max_mana : int = 15

@export var combat_actions : Array
@export var opponent : Node

@onready var health_bar : ProgressBar = get_node("HealthBar")
@onready var health_text : Label = get_node("HealthBar/Label")
@onready var mana_bar : ProgressBar = get_node("ManaBar")
@onready var mana_text : Label = get_node("ManaBar/Label")
@onready var sprite = get_node("Sprite2D")

@export var visual : Texture2D
@export var flip_visual : bool

@export var strength : int = 5
@export var vitality : int = 5
@export var magic : int = 5

@export var enemy : String = ""

var random = RandomNumberGenerator.new()

signal enemy_turn

func _ready():
	if is_player == true:
		max_mana = Global.player_max_mana
		cur_mana = Global.player_cur_mana
		max_hp = Global.player_max_hp
		cur_hp = Global.player_cur_hp
		strength = Global.player_str
		vitality = Global.player_vit
		magic = Global.player_mag
	enemy = Global.enemy
	if is_player != true:
		enemy_type()
	cur_mana = clamp(cur_mana, 0, max_mana)
	cur_hp = clamp(cur_hp, 0, max_hp)
	health_text.text = str(cur_hp, "/", max_hp)
	mana_text.text = str(cur_mana, "/", max_mana)
	$Sprite2D.texture = visual
	$Sprite2D.flip_h = flip_visual
	await get_tree().create_timer(1).timeout
	battle_scene.character_begin_turn.connect(_on_character_begin_turn)


func take_damage(damage):
	cur_hp -= damage
	_update_health_bar()
	sprite.modulate = Color(255, 255, 255)
	sprite.position.y = sprite.position.y + 20
	await get_tree().create_timer(0.15).timeout
	sprite.modulate = Color(1, 1, 1)
	sprite.position.y = sprite.position.y - 20
	
	
	if cur_hp <= 0:
		cur_hp = 0 
		var tween = create_tween().set_parallel(true)
		tween.tween_property(self, "modulate", Color(255, 0, 0, 0), 0.8)
		await get_tree().create_timer(1).timeout
		battle_scene.character_died(self)


func _physics_process(delta):
	if is_player == true:
		Global.player_max_mana = max_mana
		Global.player_cur_mana = cur_mana
		Global.player_max_hp = max_hp
		Global.player_cur_hp = cur_hp

func heal (amount):
	cur_hp += amount
	
	if cur_hp > max_hp:
		cur_hp = max_hp
	
	_update_health_bar()

func _update_health_bar ():
	health_bar.value = cur_hp
	health_text.text = str(cur_hp, "/", max_hp)

func _update_mana_bar ():
	mana_bar.value = cur_mana
	mana_text.text = str(cur_mana, "/", max_mana)

func _on_character_begin_turn(character):
	if character == self and is_player == false:
		_decide_combat_action()

func cast_combat_action(action):
	if action.mana_cost <= cur_mana:
		cur_mana -= action.mana_cost
		random.randomize()
		if action.damage > 0:
			if randf() < 0.05 and action.miss_pot == 1:
				print("You missed!")
				Global.attack_type = "Miss"
			else:
				action.damage = random.randi_range(action.min_dmg, action.max_dmg) + (strength * 2)
				opponent.take_damage(action.damage)
				print("You dealt ", str(action.damage), " DMG!")
				Global.attack_type = "Attack"
				Global.dmg_dealt = action.damage
		elif action.heal > 0:
			action.heal = random.randi_range(action.min_heal, action.max_heal) + (magic * 2)
			heal(action.heal)
			print("You healed ", str(action.heal), " HP!")
			Global.attack_type = "Heal"
			Global.dmg_dealt = action.heal
		elif action.mana_gained > 0:
			if cur_mana < max_mana:
				action.mana_gained = randi_range(action.min_mana, action.max_mana) + (magic * 2)
				cur_mana += action.mana_gained
				if cur_mana > max_mana:
					cur_mana = max_mana
				_update_mana_bar()
				print("You gained ", str(action.mana_gained), " MANA!")
				Global.attack_type = "ManaGain"
				Global.dmg_dealt = action.mana_gained
			else:
				Global.attack_type = "Nothing"
		else:
			Global.attack_type = "Nothing"
		_update_mana_bar()
	else:
		Global.attack_type = "NoMana"
	
	battle_scene.end_current_turn()

func _decide_combat_action():
	emit_signal("enemy_turn")
	var health_percent = float(cur_hp) / float(max_hp)
	for i in combat_actions:
		var action = i as CombatAction
		if action.heal > 0:
			if randf() > health_percent + 0.2 and magic > 0:
				cast_combat_action(action)
				return
			else:
				continue
		else:
			cast_combat_action(action)
			return

func enemy_type():
	if enemy == "Skeleton":
		strength = 10
		max_hp = 40
		cur_hp = 40
		magic = 5
		Global.xp_earned = randi_range(15, 30)
		Global.gold_earned = randi_range(10, 20)
		visual = load("res://Character Art/Skeleton/SkeletonBattle.png")
	elif enemy == "Orc":
		strength = 30
		cur_hp = 100
		max_hp = 100
		magic = 0
		Global.xp_earned = randi_range(90, 150)
		Global.gold_earned = randi_range(30, 60)
		visual = load("res://Character Art/Orc/OrcBattle.png")
