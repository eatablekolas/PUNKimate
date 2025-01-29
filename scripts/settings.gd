extends Node

class Tool:
	var name: String = "ERROR"
	var display_name: String = "ERROR"
	var order: int = 0
	var check_box: CheckBox = null
	
	static var last_order: int = -1
	
	static func create(name: String, display_name: String, order: int = -1) -> Tool:
		var tool: Tool = Tool.new()
		tool.name = name
		tool.display_name = display_name
		tool.order = (order if order != -1 else last_order + 1)
		last_order = tool.order
		
		return tool

var CURRENT_COLOR: Color = Color.BLACK
var CURRENT_TOOL: int = 0
var TOOLS: Array[Tool] = []

func _ready() -> void:
	TOOLS.append(Tool.create("pencil", "(P)encil"))
	TOOLS.append(Tool.create("eraser", "(E)raser"))
	
	#for tool: Tool in TOOLS:
		#print(tool.name, "\t", tool.order)
