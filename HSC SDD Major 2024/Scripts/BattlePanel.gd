extends Panel

@onready var battle_scene = get_node("..")
var player_data = PlayerData.new()

func _ready():
	pass

func _physics_process(delta):
	$HealthLabel.text = "Health: "+ str(Global.player_cur_hp) + "/" + str(Global.player_max_hp)
	$ManaLabel.text = "Mana: "+ str(Global.player_cur_mana) + "/" + str(Global.player_max_mana)
