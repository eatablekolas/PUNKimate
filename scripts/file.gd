extends PopupMenu

func _on_id_pressed(id: int) -> void:
	#var index: int = get_item_index(id)
	
	match id:
		0:
			%NewFileWindow.activate()
