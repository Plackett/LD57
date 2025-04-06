extends Area2D

var lever_on = false # Detects the level


func _on_body_entered(body: Node2D) -> void: # Toggles a True or False Boolean
	if not body.is_in_group("LeverTrigger"): return
	lever_on = not lever_on
	_level_check()


func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("LeverTrigger"): return
	lever_on = not lever_on
	_level_check()

func _level_check(): # For debugging
	if lever_on == true:
		print("on")
		get_node(get_meta("result")).activate()
		$TileMapLayer.enabled = false
		$TileMapLayer2.enabled = true
	else:
		print("off")
		get_node(get_meta("result")).deactivate()
		$TileMapLayer.enabled = true
		$TileMapLayer2.enabled = false
