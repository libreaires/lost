# SCRIPT
@tool
extends Node
class_name Stage
# END


# INSPECTOR
@export var currentRenderer: Renderer
@export var currentUI: UI
@export var currentWorld: World
@export var defaultStart: bool = true
# END


# GODOT
func _ready() -> void:
	# later find a way to generate a z_indez
	# for every child of enviroment
	currentWorld.setBackground($World/Effects, 1)
	
	if defaultStart:
		transitionIn()
		
	
# END


# METHODS
func transitionIn() -> void:
	currentUI.currentOverlay.anxiousIn()
	

func transitionOut() -> void:
	currentUI.currentOverlay.anxiousOut()
	
# END
