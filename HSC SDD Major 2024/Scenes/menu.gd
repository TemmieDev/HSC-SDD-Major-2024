extends CanvasLayer

var menu_visible : bool = false
@onready var menu = $MenuBase

func _ready():
	menu.hide()

func _physics_process(delta):
	if Global.inBattle == false:
		if Input.is_action_pressed("menu") and menu_visible == false:
			menu.show()
			get_tree().paused = true
			menu_visible == true
	else:
		pass
	$MenuBase/Health.text = str("Health: ", Global.player_cur_hp, "/", Global.player_max_hp)
	$MenuBase/Mana.text = str("Mana: ", Global.player_cur_mana, "/", Global.player_max_mana)
	$MenuBase/Health/HealthBar.max_value = Global.player_max_hp
	$MenuBase/Health/HealthBar.value = Global.player_cur_hp
	$MenuBase/Mana/ManaBar.max_value = Global.player_max_mana
	$MenuBase/Mana/ManaBar.value = Global.player_cur_mana
func _on_close_pressed():
	menu.hide()
	get_tree().paused = false
	menu_visible == false


func _on_quit_game_pressed():
	get_tree().quit()
