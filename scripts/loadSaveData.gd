extends Node2D

var FILE_PATH = "user://lsb.lk"

@export var doors : Array

func formatTime(milliseconds: int) -> String:
	var mins = 0
	var secs = 0
	var milli = milliseconds % 100
	while milliseconds >= 60 * 100:
		mins += 1
		milliseconds -= 60 * 100
	while milliseconds >= 100:
		secs += 1
		milliseconds -= 100
	return str(mins) + ":" + str(secs).pad_zeros(2) + ":" + str(milli).pad_zeros(2)

func _updateDoors(data: Array):
	for n in range(5):
		get_node(doors[n]).loadState(data[n])

func _initLeaderBoard(data: Array):
	for n in range(5):
		if data[n] != -1:
			get_node(doors[n]).AnimatedSprite2D.highscore.text = formatTime(data[n])

func _ready() -> void:
	var json = JSON.new()
	if FileAccess.file_exists(FILE_PATH):
		var file = FileAccess.open(FILE_PATH, FileAccess.READ)
		var json_text = file.get_as_text()
		file.close()
		var error = json.parse(json_text)
		if error == OK:
			var data_received = json.data
			if typeof(data_received) == TYPE_DICTIONARY:
				_updateDoors(data_received["levelStates"])
				_initLeaderBoard(data_received["bestTimes"])
				return
			else:
				print("Corrupted Data, resetting save data...")
		else:
			print("Failed to parse save file, resetting save data...")
	else:
		print("No save file found, creating new save...")
	var defaultStates = [1, 0, 0, 0, 0]
	var defaultSecrets = [0, 0, 0]
	var defaultTimes = [-1, -1, -1, -1, -1]
	var default_data = {
		"levelStates": defaultStates,
		"secretsFound": defaultSecrets,
		"bestTimes": defaultTimes
	}
	var save_file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	save_file.store_string(JSON.stringify(default_data))
	save_file.close()
	_updateDoors(defaultStates)
	_initLeaderBoard(defaultTimes)
