extends Window

@onready var min_x = self.position.x
@onready var min_y = self.position.y

func _on_close_requested() -> void:
	self.hide()

func _process(delta: float) -> void:
	var game_window_size: Vector2 = self.owner.get_viewport().get_visible_rect().size
	#print(game_window_size, "\t", position)
	
	if position.x < min_x:
		position.x = min_x
	if position.x > game_window_size.x - min_x:
		position.x = game_window_size.x - min_x
	if position.y < min_y:
		position.y = min_y
	if position.y > game_window_size.y - min_y:
		position.y = game_window_size.y - min_y
