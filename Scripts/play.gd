extends AnimatedSprite2D

@export var defaultAnimation: String = "default"
func _ready() -> void:
	play(animation)
