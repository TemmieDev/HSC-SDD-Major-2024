extends Button

var combat_action : CombatAction
@onready var battle_scene = get_node("../../../..")

signal panel

func _on_pressed():
	battle_scene.cur_char.cast_combat_action(combat_action)
	emit_signal("panel")
	
