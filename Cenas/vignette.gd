@tool
extends ColorRect
class_name Vignette

# INSPECTOR
@export_group("Vignette Properties")

@export var circleSize: float:
	set(value):
		circleSize = value
		if material: # Garante que o material existe antes de aplicar
			material.set("shader_parameter/circleSize", min(value, circleSizeLimit))
var circleSizeLimit: float = 1.0

@export var circlePosition: Vector2:
	set(value):
		circlePosition = value
		if material:
			material.set("shader_parameter/circlePosition", value)
			
		
	

@export var screenResolution: Vector2:
	set(value):
		screenResolution = value
		if material:
			material.set("shader_parameter/screenResolution", value)
			
		
	

@export var target: Node = self:
	set(value):
		target = value
		
	

@export var onlyAnimation: bool = false:
	set(value):
		onlyAnimation = value
		
	
# END


# ATRIBUTES
@onready var animator: Tween = create_tween()
@onready var following: bool = false
# END


# GODOT
func _ready() -> void:		
	# animation example
	anxiousOut()

func _process(delta: float) -> void:
	if target:
		following = true
	else:
		following = false
		
	
	if screenResolution == Vector2.ZERO:
		screenResolution = getProjectResolution()
		
	
	# setting anchor preset
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	
	# setting parameters
	if Engine.is_editor_hint() and not animator.is_valid():
		material.set("shader_parameter/circleSize", min(circleSize, circleSizeLimit))
		material.set("shader_parameter/circlePosition", circlePosition)
		material.set("shader_parameter/screenResolution", screenResolution)
		
	
	if not animator.is_valid() and onlyAnimation:
		hide()
	else:
		show()
		
	
	if target and following:
		circlePosition = target.position - self.global_position
		
	
# END


# METHODS
func newAnimator(type: StringName = "smooth") -> Tween:
	if animator and animator.is_valid(): animator.kill()
	
	animator = create_tween()
	match type:
		"smooth":
			animator.set_ease(Tween.EASE_IN_OUT)
			animator.set_trans(Tween.TRANS_SINE)
			
		
	
	# returning
	return animator

func animateMaterial (property: String, from: Variant, to: Variant, speed: float) -> void:
	if from == 0:
		from = 0.0
		
	if to == 0:
		to = 0.0
		
	
	# Setting start state
	material.set("shader_parameter/" + property, from)
	
	# Animating
	animator.tween_method(func (value: float): material.set("shader_parameter/" + property, value), from, to, speed)
	

func idle (idleSize: float = 0.1, fluctuation: float = 0.01, speed: float = 1) -> void:
	var state01: float = idleSize - fluctuation
	var state02: float = idleSize + fluctuation
	
	newAnimator()
	animateMaterial("circleSize", state01, state02, speed)
	animateMaterial("circleSize", state02, state01, speed)
	

func defaultIn (speed: float = 1) -> void:
	newAnimator()
	animateMaterial("circleSize", 0, circleSizeLimit, speed)
	

func defaultOut(speed: float = 1) -> void:
	newAnimator()
	animateMaterial("circleSize", circleSizeLimit, 0, speed)
	

func anxiousIn(inBetweenSize: float = 0.1, waitSeconds: float = 1, speed: float = 1) -> void:
	newAnimator()
	animateMaterial("circleSize", 0, inBetweenSize, speed)
	animator.tween_interval(waitSeconds)
	animateMaterial("circleSize", inBetweenSize, circleSizeLimit, speed)
	

func anxiousOut(inBetweenSize: float = 0.1, waitSeconds: float = 1, speed: float = 1) -> void:
	newAnimator()
	animateMaterial("circleSize", circleSizeLimit, inBetweenSize, speed)
	animator.tween_interval(waitSeconds)
	animateMaterial("circleSize", inBetweenSize, 0, speed)
	

func getProjectResolution() -> Vector2:
	return Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
	
# END
