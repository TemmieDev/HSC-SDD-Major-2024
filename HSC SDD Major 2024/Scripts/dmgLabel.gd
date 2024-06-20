extends Panel

var attacker
var type 
var dmg
@onready var label = $dmgText

@onready var character = get_node("../enemy_battle")

# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = str(Global.enemy, " attacks!")
	await get_tree().create_timer(1).timeout
	self.hide()
	character.enemy_turn.connect(_enemy_turn)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dmg = Global.dmg_dealt
	type = Global.attack_type
	attacker = Global.attacker
	if Global.battle_over == true:
		if Global.winner == "Player":
			self.show()
			label.text = "You Win!"
		else:
			self.show()
			label.text = "You Lost..."

func _enemy_turn():
	panel_change()


func _on_combat_action_panel():
	panel_change()

func panel_change():
	await get_tree().create_timer(0.1).timeout
	self.show()
	if type == "Attack":
		label.text = str(attacker, " dealt ", dmg, " damage!")
		await get_tree().create_timer(1).timeout
		self.hide()
	if type == "Heal":
		label.text = str(attacker, " healed ", dmg, " health!")
		await get_tree().create_timer(1).timeout
		self.hide()
	if type == "ManaGain":
		label.text = str(attacker, " restored ", dmg,  " mana!")
		await get_tree().create_timer(1).timeout
		self.hide()
	if type == "Miss":
		label.text = str(attacker, "'s attack missed! ")
		await get_tree().create_timer(1).timeout
		self.hide()
	if type == "NoMana":
		label.text = str(attacker, " doesn't have enough mana!")
		await get_tree().create_timer(1).timeout
		self.hide()
	if type == "Nothing":
		label.text = str("Nothing happened!")
