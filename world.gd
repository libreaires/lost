@tool
extends Node
class_name World


# INSPECTOR
@export var currentRenderer: Renderer
@export var currentInterface: Interface
@export var currentEnviroment: Enviroment
@export var defaultStart: bool = true
# END


# GODOT
func _ready() -> void:
	# later find a way to generate a z_indez
	# for every child of enviroment
	currentEnviroment.setBackground($Enviroment/Effects, 1)
	
	if defaultStart:
		transitionIn()
		
	
# END


# METHODS
func transitionIn() -> void:
	currentInterface.currentOverlay.anxiousIn()
	

func transitionOut() -> void:
	currentInterface.currentOverlay.anxiousOut()
	
# END
