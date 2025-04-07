extends Area2D

var accepting = false

@export var state = 1
@export var stopwatch : NodePath
@export var exit = false

var sprites = ["res://assets/textures/door_locked.png","res://assets/textures/door1.png","res://assets/textures/door_completed.png"]

func _on_body_entered(body: Node2D) -> void:
	if not body.is_class("CharacterBody2D") or state == 0: return
	$AnimatedSprite2D.visible = true
	if state == 1: $Sprite2D.texture = load("res://assets/textures/door2.png")
	accepting = true

func loadState(newState: int):
	$Sprite2D.texture = load(sprites[newState])
	state = newState

func _process(_delta: float) -> void:
	if not accepting or state == 0: return
	if not Input.is_action_pressed("ui_up"): return
	if get_meta("levelOrPos") == true:
		if exit: 
			get_node(stopwatch)._stop()
			PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
		get_tree().change_scene_to_file(get_meta("newScene"))
		return
	get_tree().get_first_node_in_group("Player").global_position = get_meta("dest")
	$AudioStreamPlayer.play(0)

func _on_body_exited(body: Node2D) -> void:
	if not body.is_class("CharacterBody2D") or state == 0: return
	$AnimatedSprite2D.visible = false
	if state == 1: $Sprite2D.texture = load("res://assets/textures/door1.png")
	accepting = false
