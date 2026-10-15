@tool
extends World
class_name Enviroment


# INSPECTOR
@export var currentBackground: Background
# END


# GODOT
func _ready() -> void:
	setBackground(currentBackground)

func _process(_delta: float) -> void:
	self.position = currentRenderer.position
	
# END


# METHODS
func generateBackground(layer: int) -> int:
	return layer * -10
	

func setBackground(target: Node2D, layer: int = 0) -> void:
	layer = layer + 1
	target.z_index = generateBackground(layer)
	
# END
