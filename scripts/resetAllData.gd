extends Button

var FILE_PATH = "user://lsb.lk"

func _on_pressed() -> void:
	var defaultStates = [1, 0, 0, 0, 0]
	var defaultSecrets = [0, 0, 0]
	var defaultTimes = [-1, -1, -1, -1, -1]
	var default_data = {
		"levelStates": defaultStates,
		"secretsFound": defaultSecrets,
		"bestTimes": defaultTimes
	}
	var json = JSON.new()
	var file = FileAccess.open(FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(default_data))
	file.close()
