# SCRIPT
@tool
extends Camera2D
class_name Renderer
# END


# INSPECTOR
@export var currentTarget: Node = self:
	set(value):
		currentTarget = value
		
	

@export var defaultStart: bool = true:
	set(value):
		defaultStart = value
		
	
# END


# ATRIBUTES
@onready var currentAnimator: Tween = create_tween()
# END


# GODOT
func _ready() -> void:
	if defaultStart:
		setZoom(1.6)
		animateView(currentTarget)
		
	
# END


# METHODS
func newAnimator(type: StringName = "smooth") -> Tween:
	if currentAnimator and currentAnimator.is_valid():
		currentAnimator.kill()
		
	
	currentAnimator = create_tween()
	match type:
		"smooth":
			currentAnimator.set_ease(Tween.EASE_IN_OUT)
			currentAnimator.set_trans(Tween.TRANS_SINE)
			
		
	
	# returning
	return currentAnimator

func animateView (target: Node = self, amount: float = 1, speed: float = 1) -> void:
	newAnimator()
	currentAnimator.tween_property(self, "position", target.position, speed)
	currentAnimator.tween_property(self, "zoom", Vector2(amount, amount), speed)
	

func setZoom (amount: float = 1) -> void:
	zoom = Vector2(amount, amount)
	
# END
