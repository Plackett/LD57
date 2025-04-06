extends Node

func activate():
	ProjectSettings.set_setting("physics/2d/default_gravity", -9.8)

func deactivate():
	ProjectSettings.set_setting("physics/2d/default_gravity", 9.8)
