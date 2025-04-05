extends Area2D

var button_on = false # Detects the button

func _on_body_entered(body: Node2D) -> void: # Turns on the button
	button_on = true
	_button_check()


func _on_body_exited(body: Node2D) -> void: # Turns off the button
	button_on = false
	_button_check()

func _button_check():
	if button_on == true:
		print("Button on")
	else:
		print("Button off")
	pass
