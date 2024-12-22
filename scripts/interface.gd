extends CanvasLayer

signal resolution_chosen(width: int, height: int)

func _on_resolution_chosen(width: int, height: int):
	resolution_chosen.emit(width, height)
