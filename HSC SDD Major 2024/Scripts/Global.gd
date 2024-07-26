extends Node

var inSubMenu : bool = false
var inMenu : bool = true
@export var enemy : String = ""

@onready var playerName : String = "Player"
var playerMaxXP
@onready var newPlayer : bool = true
@onready var inShop : bool = false

var gold
var xp_earned : int
var gold_earned : int

var baseHealth : int = 15
var player_cur_hp : int = 15
var player_max_hp : int = 15
var baseMana : int = 15
var player_cur_mana : int = 15
var player_max_mana : int = 15

var player_str : int = 5
var player_vit : int = 5
var player_mag : int = 5

var dmg_dealt : int 
var attacker : String = "Player"
var attack_type : String
var winner : String
var inBattle : bool = false
var battle_over : bool = false

var inDialog : bool = false

var player_pos : Vector2

var cur_location : String

var encounter : bool = false

const XP_DATABASE = "res://Database.json"
const MAX_LEVEL = 99
var Level : int = 1:
	set(value):
		Level = value
		levelup()
var current_xp = 0:
	set(value):
		current_xp = value
		var max_xp = get_max_xp_at(Level)
		
		if current_xp >= max_xp and Level < MAX_LEVEL:
			Level += 1
			current_xp -= max_xp
		elif Level == MAX_LEVEL:
			current_xp = 0

var XP_Table_Data = {}

func _ready():
	XP_Table_Data = get_xp_data()

func _physics_process(delta):
	playerMaxXP = get_max_xp_at(Level)
	playerName = Dialogic.VAR.playerName
	inShop = Dialogic.VAR.inShop
	gold = InvShopManager.currency

func levelup():
	player_str += 3
	player_vit += 4
	player_mag += 2
	player_max_mana = baseMana + (player_mag * 6)
	player_cur_mana = baseMana + (player_mag * 6)
	player_max_hp = baseHealth + (player_vit * 10)
	player_cur_hp = baseHealth + (player_vit * 10)
	playerMaxXP = get_max_xp_at(Level)


func get_xp_data():
	var file = FileAccess.open(XP_DATABASE, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	return data

func get_max_xp_at(level):
	return XP_Table_Data[str(level)]["need"]
