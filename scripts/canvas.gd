extends Sprite2D

const SIZE_X: int = 400
const SIZE_Y: int = 400
const ERROR_VECTOR: Vector2i = Vector2i(-1, -1)

@onready var image: Image = Image.create_empty(SIZE_X, SIZE_Y, false, Image.FORMAT_RGBA8)
@onready var image_texture: ImageTexture = ImageTexture.create_from_image(image)

@export var camera: Camera2D

var pressed: bool = false

func mouse_to_point(mouse_position: Vector2) -> Vector2i:
	var window_size = DisplayServer.window_get_size()
	
	var x: int = (mouse_position.x - window_size.x / 2) / camera.zoom.x + camera.position.x + SIZE_X / 2
	var y: int = (mouse_position.y - window_size.y / 2) / camera.zoom.y + camera.position.y + SIZE_Y / 2
	
	return Vector2i(x, y)

func is_point_valid(point: Vector2i) -> bool:
	return (point.x >= 0 and point.x < SIZE_X and point.y >= 0 and point.y < SIZE_Y)

func draw_pixel(mouse_position: Vector2i) -> void:
	var pos: Vector2i = mouse_to_point(mouse_position)
	if not is_point_valid(pos):
		return
	
	image.set_pixelv(pos, Color.BLACK)
	image_texture.update(image)

func _ready() -> void:
	image.fill(Color.WHITE)
	image_texture.update(image)
	self.texture = image_texture

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_CTRL):
		return
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pressed = event.pressed
			
			if pressed:
				draw_pixel(event.position)
	elif event is InputEventMouseMotion and pressed:
		draw_pixel(event.position)
