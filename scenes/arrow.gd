extends Area2D

func _process(delta: float) -> void:
	global_position.x += 1 / delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): body.kill()
