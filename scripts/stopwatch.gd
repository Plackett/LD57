extends Node

var time : float = 0.0
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
	json.parse(json_text)
	var data_received = json.data
	if typeof(data_received) == TYPE_DICTIONARY:
		data_received["levelStates"][index] = 2
		if data_received["levelStates"][unlock] == 0: data_received["levelStates"][unlock] = 1
		if data_received["bestTimes"][index] > time or data_received["bestTimes"][index] == -1 : data_received["bestTimes"][index] = time
		var result = FileAccess.open(FILE_PATH, FileAccess.WRITE)
		result.store_string(JSON.stringify(json.data))
		result.close()
