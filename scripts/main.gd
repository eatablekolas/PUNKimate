extends Node2D

@onready var canvas: Canvas = %Canvas

func _on_resolution_chosen(width: int, height: int) -> void:
	canvas.make_new(width, height)
