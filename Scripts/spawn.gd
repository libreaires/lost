# SCRIPT
extends Node
class_name Spawn
# END


# INSPECTOR
@export var target: Node2D
@export var invisible: bool = true
@export var debugSprite: Sprite2D
@export var spawnAnimation: PackedScene = preload("res://Cenas/spawnParticle.tscn")
# END


# GODOT
func _ready() -> void:
	if invisible: debugSprite.hide()
	
# END


# METHODS
func onSpawned() -> void:
	var newAnimation = spawnAnimation.instantiate()
	add_child(newAnimation)
	
# END
