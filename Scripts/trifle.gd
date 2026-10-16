# SCRIPT
extends Enemy
class_name Trifle
# END


# INSPECTOR
@export_group("Properties")
@export var spawnDelay: float = 10
# END


# ENUMERATORS
enum States {
	SPAWNING1,
	SPAWNING2,
	WALKING,
	ATTACK,
	DEATH,
}
# END


# GODOT
func _process(_delta: float) -> void:
	processStates()
	
# END


# METHODS
func processStates() -> void:
	pass
	
# END
