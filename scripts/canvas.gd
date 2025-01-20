extends Sprite2D
class_name Canvas

#const SIZE_X: int = 400
#const SIZE_Y: int = 400
const ERROR_VECTOR: Vector2i = Vector2i(-1, -1)

var size: Vector2i = Vector2i(400, 400)
var pressed: bool = false
var last_pos: Vector2i = Vector2.ZERO

@onready var image: Image = Image.create_empty(size.x, size.y, false, Image.FORMAT_RGBA8)
@onready var image_texture: ImageTexture = ImageTexture.create_from_image(image)

@export var camera: Camera2D

func make_new(x: int, y: int) -> void:
	size = Vector2i(x, y)
	image.crop(x, y)
	image.fill(Color.WHITE)
	image_texture.set_image(image)

func mouse_to_point(mouse_position: Vector2) -> Vector2i:
	var window_size = DisplayServer.window_get_size()
	
	var x: int = (mouse_position.x - window_size.x / 2) / camera.zoom.x + camera.position.x + size.x / 2
	var y: int = (mouse_position.y - window_size.y / 2) / camera.zoom.y + camera.position.y + size.y / 2
	
	return Vector2i(x, y)

func is_point_valid(point: Vector2i) -> bool:
	return (point.x >= 0 and point.x < size.x and point.y >= 0 and point.y < size.y)

func draw_pixel(pos: Vector2i) -> void:
	if not is_point_valid(pos):
		return
	
	image.set_pixelv(pos, Color.BLACK)

func plot_line_low(pos1: Vector2i, pos2: Vector2i) -> void:
	var dx: int = pos2.x - pos1.x
	var dy: int = pos2.y - pos1.y
	var yi: int = 1
	
	if dy < 0:
		yi = -1
		dy = -dy
	
	var D: int = (2 * dy) - dx
	var y: int = pos1.y

	for x in range(pos1.x, pos2.x + 1):
		draw_pixel(Vector2i(x, y))
		if D > 0:
			y += yi
			D += (2 * (dy - dx))
		else:
			D += 2 * dy

func plot_line_high(pos1: Vector2i, pos2: Vector2i) -> void:
	var dx: int = pos2.x - pos1.x
	var dy: int = pos2.y - pos1.y
	var xi: int = 1
	
	if dx < 0:
		xi = -1
		dx = -dx
	
	var D: int = (2 * dx) - dy
	var x: int = pos1.x

	for y in range(pos1.y, pos2.y + 1):
		draw_pixel(Vector2i(x, y))
		if D > 0:
			x += xi
			D += (2 * (dx - dy))
		else:
			D += 2 * dx

func plot_line(pos1: Vector2i, pos2: Vector2i) -> void:
	if abs(pos2.y - pos1.y) < abs(pos2.x - pos1.x):
		if pos1.x > pos2.x:
			plot_line_low(pos2, pos1)
		else:
			plot_line_low(pos1, pos2)
	else:
		if pos1.y > pos2.y:
			plot_line_high(pos2, pos1)
		else:
			plot_line_high(pos1, pos2)

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
				var pos: Vector2i = mouse_to_point(event.position)
				
				draw_pixel(pos)
				image_texture.update(image)
				
				last_pos = pos
	elif event is InputEventMouseMotion and pressed:
		var pos: Vector2i = mouse_to_point(event.position)
		
		plot_line(last_pos, pos)
		image_texture.update(image)
		
		last_pos = pos
