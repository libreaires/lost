# script
@tool
extends Node2D
class_name AnchoredElement

# enumerators
enum Anchor {
	Center,
	TopWest, TopEast,
	BottomWest, BottomEast,
}

# exports
@export var currentResolution: Vector2 = Vector2(640, 480)
@export var currentOffset: Vector2 = Vector2(0, -80)
@export var currentAnchor: Anchor
@export var debugMode: bool = false
@export var debugSprite: Sprite2D

# on ready
@onready var anchorPositions = {
	"top": {
		"east": Vector2(currentResolution.x - currentResolution.x / 4, (currentResolution.y / 2) * -1),
	},
}

# godot
func _ready() -> void:
	anchorMatching()
	position = position + currentOffset
	if debugMode:
		debugSprite.show()
	else:
		debugSprite.hide()
		
	

# methods
func anchorMatching() -> void:
	match currentAnchor:
		Anchor.TopEast:
			position = anchorPositions["top"]["east"]
			
		
	
