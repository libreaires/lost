extends Node2D
class_name Spawn

# inspector
@export var target: Node2D
@export var invisible: bool = true
@export var debugSprite: Sprite2D
@export var spawnAnimation: PackedScene = preload("res://Cenas/spawnParticle.tscn")

# methods
func _ready() -> void:
	if invisible: debugSprite.hide()
	

func onSpawned() -> void:
	var newAnimation = spawnAnimation.instantiate()
	add_child(newAnimation)
