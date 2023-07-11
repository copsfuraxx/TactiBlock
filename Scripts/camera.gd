extends Camera2D

@export
var player: CharacterBody2D

@export
var ui: Control

@onready
var margin = player.position.x - position.x

func _process(_delta):
	position.x = player.position.x - margin
