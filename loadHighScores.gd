extends RichTextLabel

var FILE_PATH = "user://lsb.lk"

func _ready() -> void:
	var json = JSON.new()
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	json.parse(json_text)
	var data_received = json.data
	if typeof(data_received) == TYPE_DICTIONARY:
		text = ""
		for n in 5:
			text += "Level " + str(n+1) + ": " + str(data_received["bestTimes"][n]) + " seconds!\n"
