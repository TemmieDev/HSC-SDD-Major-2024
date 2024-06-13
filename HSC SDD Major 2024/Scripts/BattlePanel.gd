extends Panel

@onready var battle_scene = get_node("..")
var player_data = PlayerData.new()

func _ready():
	pass

func _physics_process(delta):
	$HealthLabel.text = "Health: "+ str(player_data.cur_hp) + "/" + str(player_data.max_hp)
	$ManaLabel.text = "Mana: "+ str(player_data.cur_mana) + "/" + str(player_data.max_mana)
