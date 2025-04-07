extends Button

@export var menu : MenuBar
@export var menu2 : MenuBar
var activated = false

func toggle():
	activated = not activated
	if activated:
		menu.visible = false
		menu2.visible = true
		get_tree().paused = true
	else:
		menu.visible = true
		menu2.visible = false
		get_tree().paused = false

func _on_pressed() -> void:
	toggle()

func _on_button_3_pressed() -> void:
	toggle() 
