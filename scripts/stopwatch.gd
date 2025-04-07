extends Node

var time = 0
var counting = true

var FILE_PATH = "user://lsb.lk"

@export var index : int
@export var unlock : int

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting: time += delta

func _stop():
	var json = JSON.new()
	counting = false
	var file = FileAccess.open(FILE_PATH, FileAccess.READ)
	var json_text = file.get_as_text()
	file.close()
	var error = json.parse(json_text)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			data_received["levelStates"][index] = 2
			if data_received["levelStates"][unlock] == 0: data_received["levelStates"][unlock] = 1
			if data_received["bestTimes"][index] > time: data_received["bestTimes"][index] = time
			file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
			file.store_string(JSON.stringify(json))
			file.close()
				
