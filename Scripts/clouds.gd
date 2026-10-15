extends AnimatedSprite2D

@export var camera: Camera2D = null
var startHeight: float
func _ready() -> void:
	startHeight = position.y
func _process(delta: float) -> void:
	position.y = camera.position.y + startHeight
