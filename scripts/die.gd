extends Node2D

@export var player : CharacterBody2D

func _on_button_2_pressed() -> void:
	player.die()
