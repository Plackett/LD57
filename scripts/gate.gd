extends Node2D

func activate():
	$TileMapLayer2.enabled = false
	$TileMapLayer.enabled = true

func deactivate():
	$TileMapLayer2.enabled = true
	$TileMapLayer.enabled = false
