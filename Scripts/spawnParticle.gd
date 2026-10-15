extends Node2D
class_name SpawnParticle

@export var circle: Sprite2D
@export var startSize: Vector2 = Vector2(0, 0)
@export var finalSize: Vector2 = Vector2(1, 1)
@export var speed: float = 1

func _ready() -> void:
	circle.scale = startSize
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(circle, "scale", finalSize, speed)
	tween.tween_property(circle, "scale", startSize, speed)
	tween.tween_callback(queue_free)
