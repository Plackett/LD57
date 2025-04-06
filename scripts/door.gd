extends Area2D

var accepting = false

func _on_body_entered(body: Node2D) -> void:
	if(not body.is_class("CharacterBody2D")):
		return
	$AnimatedSprite2D.visible = true
	$Sprite2D.texture = load("res://assets/textures/door2.png")
	accepting = true

func _process(_delta: float) -> void:
	if not accepting: return
	if not Input.is_action_pressed("ui_up"): return
	if get_meta("levelOrPos") == true:
		get_tree().change_scene_to_file(get_meta("newScene"))
		return
	get_tree().get_first_node_in_group("Player").global_position = get_meta("dest")
	$AudioStreamPlayer.play(0)

func _on_body_exited(body: Node2D) -> void:
	if(not body.is_class("CharacterBody2D")):
		return
	$AnimatedSprite2D.visible = false
	$Sprite2D.texture = load("res://assets/door1.png")
	accepting = false
