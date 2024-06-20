extends Panel

@onready var battle_scene = get_node("..")
var player_data = PlayerData.new()

func _ready():
	pass

func _physics_process(delta):
	$HealthLabel.text = "Health: "+ str(Global.player_cur_hp) + "/" + str(Global.player_max_hp)
	$ManaLabel.text = "Mana: "+ str(Global.player_cur_mana) + "/" + str(Global.player_max_mana)
	$HealthLabel/HealthBar.max_value = Global.player_max_hp
	$HealthLabel/HealthBar.value = Global.player_cur_hp
	$ManaLabel/ManaBar.max_value = Global.player_max_mana
	$ManaLabel/ManaBar.value = Global.player_cur_mana
