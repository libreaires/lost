# SCRIPT
@tool
extends Node
class_name Effect
# END


# ATRIBUTES
@onready var currentAnimator: Tween
# END


# METHODS
func newAnimator(type: StringName = "smooth") -> Tween:
	if currentAnimator and currentAnimator.is_valid():
		currentAnimator.kill()
		
	
	currentAnimator = create_tween()
	
	if Engine.is_editor_hint():
		currentAnimator.set_loops()
		
	
	match type:
		"smooth":
			currentAnimator.set_ease(Tween.EASE_IN_OUT)
			currentAnimator.set_trans(Tween.TRANS_SINE)
			
		
	
	# returning
	return currentAnimator
	


func endAnimation() -> void:
	if not Engine.is_editor_hint():
		currentAnimator.tween_callback(queue_free)
	
#END
