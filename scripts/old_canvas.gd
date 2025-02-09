extends Sprite2D

const LINE_SCENE: PackedScene = preload("res://scenes/line.tscn")

var pressed: bool = false
var current_line: Line2D = null

func mouse_to_point(mouse_position: Vector2) -> Vector2:
	var window_size = DisplayServer.window_get_size()
	
	var x: float = mouse_position.x - window_size.x / 2 + %Camera.position.x
	var y: float = mouse_position.y - window_size.y / 2 + %Camera.position.y
	
	return Vector2(x, y)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_CTRL):
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pressed = event.pressed
			
			if pressed:
				current_line = LINE_SCENE.instantiate()
				current_line.add_point(mouse_to_point(event.position))
				%Lines.add_child(current_line)
	elif event is InputEventMouseMotion and pressed:
		current_line.add_point(mouse_to_point(event.position))

#func _process(delta: float) -> void:
	#if pos.y >= SIZE_Y:
		#return
	#
	#for x in range(0, SIZE_X - 1):
		#image.set_pixelv(pos, Color.from_hsv(float(pos.x * pos.y) / float(SIZE_X * SIZE_Y), 1, 1))
		#pos.x += 1
	#
	#image.set_pixelv(pos, Color.from_hsv(float(pos.x * pos.y) / float(SIZE_X * SIZE_Y), 1, 1))
	#
	#pos.x = 0
	##pos.x += 1
	#pos.y += 1
	#image_texture.update(image)
