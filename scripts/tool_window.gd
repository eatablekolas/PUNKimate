extends Window

@onready var min_x: int = self.position.x
@onready var min_y: int = self.position.y

func _ready() -> void:
	var button_group: ButtonGroup = ButtonGroup.new()
	
	for check_box: CheckBox in %Tools.get_children():
		check_box.queue_free()
	
	for tool: Settings.Tool in Settings.TOOLS:
		var check_box: CheckBox = CheckBox.new()
		check_box.text = tool.display_name
		check_box.button_group = button_group
		%Tools.add_child(check_box)
		tool.check_box = check_box
	
	var default_tool: Settings.Tool = Settings.TOOLS[0]
	default_tool.check_box.button_pressed = true

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
	
	for tool: Settings.Tool in Settings.TOOLS:
		if Input.is_action_just_pressed(tool.name):
			tool.check_box.button_pressed = true
			
			if tool.name == "pencil":
				Settings.CURRENT_COLOR = Color.BLACK
			elif tool.name == "eraser":
				Settings.CURRENT_COLOR = Color.WHITE

func _on_close_requested() -> void:
	self.hide()
