# SCRIPT
@tool
extends Effect
# END


# INSPECTOR
@export var circle01: Sprite2D:
	set(value):
		circle01 = value
		if is_node_ready():
			_ready()
		
	

@export var circle02: Sprite2D:
	set(value):
		circle02 = value
		if is_node_ready():
			_ready()
		
	

@export var startSize: Vector2 = Vector2(0, 0):
	set(value):
		startSize = value
		if is_node_ready():
			_ready()
		
	

@export var finalSize: Vector2 = Vector2(1, 1):
	set(value):
		finalSize = value
		if is_node_ready():
			_ready()
		
	

@export var speed: float = 1:
	set(value):
		speed = value
		if is_node_ready():
			_ready()
		
	
# END


# GODOT
func _ready() -> void:
	
	circle01.scale = startSize
	circle02.scale = startSize
	circle02.modulate = Color(1, 1, 1, 0.5)
	
	newAnimator()
	currentAnimator.tween_property(circle01, "scale", finalSize, speed)
	currentAnimator.parallel().tween_property(circle02, "scale", finalSize, speed * 1.6)
	currentAnimator.chain()
	currentAnimator.tween_property(circle01, "scale", startSize, speed)
	currentAnimator.parallel().tween_property(circle02, "scale", startSize, speed * 1.6)
	endAnimation()
	
# END
