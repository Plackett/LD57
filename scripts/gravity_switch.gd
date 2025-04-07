extends Node

@export var player : NodePath

func activate():
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.UP)
	get_node(player).set_up_direction(Vector2.DOWN)

func deactivate():
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	get_node(player).set_up_direction(Vector2.UP)
