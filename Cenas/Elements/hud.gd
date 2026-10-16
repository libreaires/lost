@tool
extends UI
class_name HUD


# INSPECTOR
@export var currentOverlay: ColorRect
# END


# GODOT
func _ready() -> void:
	fitCurrentView()
	
# END


# METHODS
func fitCurrentView() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	size = getProjectResolution()
	

func getProjectResolution() -> Vector2:
	return Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	
# END
