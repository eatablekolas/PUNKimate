extends Sprite2D

const SIZE_X: int = 400
const SIZE_Y: int = 400

@onready var image: Image = Image.create_empty(SIZE_X, SIZE_Y, false, Image.FORMAT_RGBA8)
@onready var image_texture: ImageTexture = ImageTexture.create_from_image(image)

var pos: Vector2i = Vector2i.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image.fill(Color.WHITE)
	image_texture.update(image)
	self.texture = image_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if pos.y >= SIZE_Y:
		return
	
	#for x in range(0, SIZE_X):
		#image.set_pixelv(pos, Color.from_hsv(float(pos.x * pos.y) / float(SIZE_X * SIZE_Y), 1, 1))
		#pos.x += 1
	
	image.set_pixelv(pos, Color.from_hsv(float(pos.x * pos.y) / float(SIZE_X * SIZE_Y), 1, 1))
	
	#pos.x = 0
	pos.x += 1
	pos.y += 1
	image_texture.update(image)
