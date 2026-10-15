@tool
extends Control
class_name ViewDepth

@export var depth: Parallax2D:
	set(value):
		depth = value
		
	

func _process(delta: float) -> void:
	depth.repeat_size = size
	
