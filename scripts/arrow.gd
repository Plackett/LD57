extends Area2D

var timeAlive = 0.0

func _process(delta: float) -> void:
	global_position.x += 0.01 / delta
	timeAlive += delta
	if timeAlive > 20: queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): body.kill()
