extends Node

class Tool:
	var name: String = "ERROR"
	var order: int = 0
	static var last_order: int = -1
	
	static func create(name: String, order: int = -1) -> Tool:
		var tool: Tool = Tool.new()
		tool.name = name
		tool.order = (order if order != -1 else last_order + 1)
		last_order = tool.order
		
		return tool

var CURRENT_TOOL: int = 0
var TOOLS: Array[Tool] = []

func _ready() -> void:
	TOOLS.append(Tool.create("Pencil"))
	TOOLS.append(Tool.create("Eraser"))
	
	#for tool: Tool in TOOLS:
		#print(tool.name, "\t", tool.order)
