extends CollisionShape2D

@export var endingScene : String
@export var timer : NodePath

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_node(timer)._stop()
	get_tree().change_scene_to_file(endingScene)
