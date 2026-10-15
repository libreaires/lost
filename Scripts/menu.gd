extends Control

@export var playButton: Button
@export var quitButton: Button
@export var playScene: PackedScene

func playPressed() -> void:
	get_tree().change_scene_to_packed(playScene)


func quitPressed() -> void:
	queue_free()
