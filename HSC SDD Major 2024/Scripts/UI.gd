extends CanvasLayer

var menu_visible : bool = false
@onready var menu = $MenuBase

enum MODE {
	INVENTORY,
	SHOP
}
 
func open_mode(mode,items):
	%Shop.load_items(items)
	%Manager.open_mode(mode)

func _ready():
	menu.hide()

func _physics_process(delta):
	if Global.inBattle == false and Global.inDialog == false and Global.inMenu == false:
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
	$MenuBase/VBoxContainer2/HBoxContainer/PlayerName.text = str(Global.playerName, "'s Level: ")
	$MenuBase/VBoxContainer2/HBoxContainer/PlayerLvl.text = str(Global.Level)
	$MenuBase/VBoxContainer/Strength.text = str("Strength: ", Global.player_str)
	$MenuBase/VBoxContainer/Vitality.text = str("Vitality: ", Global.player_vit)
	$MenuBase/VBoxContainer/Magic.text = str("Magic: ", Global.player_mag)
	$MenuBase/VBoxContainer2/CurrentXP.text = str("Current XP: ", Global.current_xp)
	$MenuBase/VBoxContainer2/XPUntilNext.text = str("XP needed for next Lvl: ", Global.playerMaxXP)
func _on_close_pressed():
	menu.hide()
	get_tree().paused = false
	menu_visible == false


func _on_quit_game_pressed():
	SceneChanger.switch_scene("res://Scenes/main_menu.tscn")
	menu.hide()
	get_tree().paused = false
	menu_visible == false
	

func ItemPopup(slot : Rect2i, item : Item):
	if item != null:
		set_value(item)
		%ItemPopup.size = Vector2i.ZERO
 
	var mouse_pos = get_viewport().get_mouse_position()
	var correction
	var padding = 4
 
	if mouse_pos.x <= get_viewport().get_visible_rect().size.x/2:
		correction = Vector2i(slot.size.x + padding, 0)
	else:
		correction = -Vector2i(%ItemPopup.size.x + padding, 0)
 
	%ItemPopup.popup(Rect2i( slot.position + correction, %ItemPopup.size ))
 
func HideItemPopup():
	%ItemPopup.hide()
 
 
func set_value(item : Item):
	%Name.text = item.name
	%Value.text = str(item.cost)
	%Description.text = item.desc


func _on_close_shop_pressed():
	%Manager.hide()
	if menu_visible == true:
		%MenuBase.show()
	Global.inDialog = false


func _on_return_pressed():
	SceneChanger.switch_scene("res://Scenes/Base.tscn")
	menu.hide()
	get_tree().paused = false
	menu_visible == false
