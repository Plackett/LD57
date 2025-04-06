extends Area2D

var lever_on = false # Detects the level


func _on_body_entered(body: Node2D) -> void: # Toggles a True or False Boolean
	lever_on = not lever_on
	_level_check()


func _level_check(): # For debugging
	if lever_on == true:
		print("on")
	else:
		print("off")
