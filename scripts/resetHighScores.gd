extends Button

var FILE_PATH = "user://lsb.lk"

func _on_pressed() -> void:
	var json = JSON.new()
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	json.parse(json_text)
	var data_received = json.data
	if typeof(data_received) == TYPE_DICTIONARY:
		data_received["bestTimes"] = [-1,-1,-1,-1,-1]
		var result = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		result.store_string(JSON.stringify(json.data))
		result.close()
