extends Area2D

var accepting = false

func _on_body_entered(body: Node2D) -> void:
	if(not body.is_class("CharacterBody2D")):
		return
	$AnimatedSprite2D.visible = true
	$Sprite2D.texture = load("res://assets/door2.png")
	accepting = true

func _process(delta: float) -> void:
	if not accepting: return
	if Input.is_action_pressed("ui_up"):
		get_tree().change_scene_to_file($newScene)

func _on_body_exited(body: Node2D) -> void:
	if(not body.is_class("CharacterBody2D")):
		return
	$AnimatedSprite2D.visible = false
	$Sprite2D.texture = load("res://assets/door1.png")
	accepting = false
