extends Node

@export var two_players : bool = false
@export var enemy : String = ""

var player_cur_hp : int = 25
var player_max_hp : int = 25
var player_cur_mana : int = 15
var player_max_mana : int = 15

var dmg_dealt : int 
var attacker : String = "Player"
var attack_type : String
var winner : String
var battle_over : bool = false
