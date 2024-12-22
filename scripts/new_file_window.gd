extends Window

signal resolution_chosen(width: int, height: int)

func _on_close_requested() -> void:
	self.hide()


func _on_ok_pressed() -> void:
	var width: int = int(%Width.value)
	var height: int = int(%Height.value)
	
	resolution_chosen.emit(width, height)
	self.hide()

func _on_cancel_pressed() -> void:
	self.hide()
