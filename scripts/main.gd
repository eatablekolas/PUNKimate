extends Node2D

func _on_resolution_chosen(width: int, height: int) -> void:
	#var window_size = DisplayServer.window_get_size()
	
	%Canvas.scale = Vector2(width, height)
	%Canvas.show()
