extends Node

@export var enemy : String = ""

var player_cur_hp : int = 25
var player_max_hp : int = 25
var player_cur_mana : int = 15
var player_max_mana : int = 15

var player_str : int = 8
var player_vit : int = 10
var player_mag : int = 5

var dmg_dealt : int 
var attacker : String = "Player"
var attack_type : String
var winner : String
var inBattle : bool = false
var battle_over : bool = false

var player_pos : Vector2

var cur_location : String

func levelup():
	player_max_mana = player_max_mana * player_mag /5
	player_cur_mana = player_cur_mana * player_mag /5
	player_max_hp = (player_max_hp * player_vit) /5
	player_cur_hp = player_cur_hp * player_vit /5
