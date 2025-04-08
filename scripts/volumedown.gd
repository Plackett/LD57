extends Button

func _on_pressed() -> void:
	var oldVolume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), oldVolume - 1)
