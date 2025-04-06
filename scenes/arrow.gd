extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += Vector2(1,0);

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): body.kill()
