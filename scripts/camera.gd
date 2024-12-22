extends Camera2D

const ZOOM_INCREMENT: float = 0.05
const ZOOM_MIN: float = 0.25
const ZOOM_MAX: float = 10.0

var panning: bool = false
var zoom_level: float = 1.0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if Input.is_key_pressed(KEY_CTRL):
					if event.pressed:
						panning = true
					else:
						panning = false
					get_tree().get_root().set_input_as_handled()
			MOUSE_BUTTON_WHEEL_UP:
				zoom_level = clamp(zoom_level + ZOOM_INCREMENT, ZOOM_MIN, ZOOM_MAX)
				zoom = zoom_level * Vector2.ONE
				get_tree().get_root().set_input_as_handled()
			MOUSE_BUTTON_WHEEL_DOWN:
				zoom_level = clamp(zoom_level - ZOOM_INCREMENT, ZOOM_MIN, ZOOM_MAX)
				zoom = zoom_level * Vector2.ONE
				get_tree().get_root().set_input_as_handled()
	elif event is InputEventMouseMotion and panning:
		get_tree().get_root().set_input_as_handled()
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Input.is_key_pressed(KEY_CTRL):
			global_position -= event.relative / zoom_level
		else:
			panning = false
