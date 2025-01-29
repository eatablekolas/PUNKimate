extends CanvasLayer

signal resolution_chosen(width: int, height: int)

func _on_resolution_chosen(width: int, height: int):
	resolution_chosen.emit(width, height)

func _ready() -> void:
	#var base_position = DisplayServer.window_get_position()
	
	for window: Window in %SubWindows.get_children():
		#window.position += base_position
		window.show()
