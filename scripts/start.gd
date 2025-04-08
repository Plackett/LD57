extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not Input.is_key_pressed(KEY_ENTER): return
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")
