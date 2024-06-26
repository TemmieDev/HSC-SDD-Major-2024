extends Panel

enum MODE {
	INVENTORY,
	SHOP
}

@export var currency : int = 0:
	set(value):
		currency = value
		currency = Global.gold
		%Balance.text = str(value)

func _ready():
	pass

func _input(event):
	pass
	#if event.is_action_pressed("menu"):
		#open_mode(MODE.INVENTORY)
	
	#testing
	#if event.is_action_pressed("interact"):
		#open_mode(MODE.SHOP)


func open_mode(mode):
	visible = not visible
	
	match mode:
		MODE.INVENTORY:
			%Shop.visible = false
			%Title.text = "Inventory"
			if visible:
				print("Inventory mode.")
		
		MODE.SHOP:
			%Shop.visible = true
			%Title.text = "Shop"
			if visible:
				print("Shop mode.")


func _on_inventory_button_pressed():
	open_mode(MODE.INVENTORY)
	%MenuBase.hide()
