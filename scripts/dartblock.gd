extends RigidBody2D

var timer = 0.0
@export var arrow : PackedScene

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer < 1: return
	timer = 0.0
	var arrowInstance = arrow.instantiate()
	arrowInstance.global_position = global_position
	get_parent().add_child(arrowInstance)
