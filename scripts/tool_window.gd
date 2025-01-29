extends Window

@onready var min_x: int = self.position.x
@onready var min_y: int = self.position.y

var tools: Dictionary = {}

func _ready() -> void:
	#for check_box: CheckBox in %Tools.get_children():
		#check_box.queue_free()
	#
	#for tool: Settings.Tool in Settings.TOOLS:
		#pass
	
	for check_box: CheckBox in %Tools.get_children():
		tools[check_box.name.to_lower()] = check_box

func _process(_delta: float) -> void:
	var game_window_size: Vector2 = self.owner.get_viewport().get_visible_rect().size
	
	if position.x < min_x:
		position.x = int(min_x)
	if position.x > game_window_size.x - min_x - self.size.x:
		position.x = int(game_window_size.x - min_x - self.size.x)
	if position.y < min_y:
		position.y = int(min_y)
	if position.y > game_window_size.y - min_y - self.size.y / 2:
		position.y = int(game_window_size.y - min_y - self.size.y / 2)
	
	for tool_name: String in tools:
		if Input.is_action_just_pressed(tool_name):
			var check_box: CheckBox = tools[tool_name]
			check_box.button_pressed = true

func _on_close_requested() -> void:
	self.hide()
