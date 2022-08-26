extends Node

var save_path: String = "user://settings.dat"

var settings: Dictionary = {
	"master_volume": 0,
	"music_volume": 0,
	"effect_volume": 0
}

func _ready() -> void:
	read()

func read() -> void:
	var file = File.new()
	if file.file_exists(save_path):
		var error1 = file.open(save_path, File.READ)
		if error1 == OK:
			settings = file.get_var()
			file.close()

func write() -> void:
	var file = File.new()
	var error2 = file.open(save_path, File.WRITE)
	if error2 == OK:
		file.store_var(settings)
		file.close()
