extends Sprite2D

const SIZE_X: int = 400
const SIZE_Y: int = 400
const ERROR_VECTOR: Vector2i = Vector2i(-1, -1)

@onready var image: Image = Image.create_empty(SIZE_X, SIZE_Y, false, Image.FORMAT_RGBA8)
@onready var image_texture: ImageTexture = ImageTexture.create_from_image(image)

@export var camera: Camera2D

var pressed: bool = false
var last_pos: Vector2i = Vector2.ZERO

func mouse_to_point(mouse_position: Vector2) -> Vector2i:
	var window_size = DisplayServer.window_get_size()
	
	var x: int = (mouse_position.x - window_size.x / 2) / camera.zoom.x + camera.position.x + SIZE_X / 2
	var y: int = (mouse_position.y - window_size.y / 2) / camera.zoom.y + camera.position.y + SIZE_Y / 2
	
	return Vector2i(x, y)

func is_point_valid(point: Vector2i) -> bool:
	return (point.x >= 0 and point.x < SIZE_X and point.y >= 0 and point.y < SIZE_Y)

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
	
	#if pos1.x > pos2.x:
		#var pom: Vector2i = pos1
		#pos1 = pos2
		#pos2 = pom
	#
	#var diff_x: int = abs(pos1.x - pos2.x)
	#var diff_y: int = abs(pos1.y - pos2.y)
	#var increment: int = 1 if pos2.y - pos1.y > 0 else -1
	#
	#if diff_x < diff_y and pos1.x < pos2.x and pos1.y > pos2.y:
		#var pom: Vector2i = pos1
		#pos1 = pos2
		#pos2 = pom
	#
	#if diff_x > diff_y:
		#var A: int = 2 * diff_y
		#var B: int = A - 2 * diff_x
		#var P: int = A - diff_x
		#var y: int = pos1.y
		#
		#for x in range(pos1.x + 1, pos2.x + 1):
			#if P < 0:
				#draw_pixel(Vector2i(x, y))
				#P += A
			#else:
				#y += increment
				#draw_pixel(Vector2i(x, y))
				#P += B
	#else:
		#var A: int = 2 * diff_x
		#var B: int = A - 2 * diff_y
		#var P: int = A - diff_y
		#var x: int = pos1.x
		#
		#for y in range(pos1.y + 1, pos2.y + 1):
			#if P < 0:
				#draw_pixel(Vector2i(x, y))
				#P += A
			#else:
				#x += increment
				#draw_pixel(Vector2i(x, y))
				#P += B

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
		
		draw_pixel(pos)
		plot_line(last_pos, pos)
		image_texture.update(image)
		
		last_pos = pos
