extends Spawn
class_name RelativeSpawn

# inspector
@onready var distance: Vector2 = target.position - position

# methods
func _process(_delta: float) -> void:
	position = target.position - distance
	
