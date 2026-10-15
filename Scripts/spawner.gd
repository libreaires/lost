extends Enemy

@export_group("Properties")
@export var spawnDelay: float = 10


enum States {
	SPAWNING1,
	SPAWNING2,
	WALKING,
	ATTACK,
	DEATH,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	processStates(delta)
	
func processStates(delta: float) -> void:
	pass
