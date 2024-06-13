extends Node

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "890GFDSG"

var player_data = PlayerData.new()

func _ready():
	verify_save_directory(SAVE_DIR)


func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)


func save_data(path : String):
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var data = {
		"player_data": {
			"max_hp": player_data.max_hp,
			"cur_hp": player_data.cur_hp,
			"player_pos":{
				"x": player_data.player_pos.x,
				"y": player_data.player_pos.y,
			},
			"max_mana": player_data.max_mana,
			"cur_mana": player_data.cur_mana
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()

func load_data(path : String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse %s as a json_string" % [path, content])
			return
		
		player_data = PlayerData.new()
		player_data.max_hp = data.player_data.max_hp
		player_data.cur_hp = data.player_data.cur_hp
		player_data.max_mana = data.player_data.max_mana
		player_data.cur_mana = data.player_data.cur_mana
		player_data.player_pos = Vector2(data.player_data.player_pos.x, data.player_data.player_pos.y)
		
		
	else:
		printerr("Cannot open non-existent file at %s" %[path])
	

func run_save():
	save_data(SAVE_DIR + SAVE_FILE_NAME)

func run_load():
	load_data(SAVE_DIR + SAVE_FILE_NAME)
