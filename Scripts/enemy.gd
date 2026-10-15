extends Area2D
class_name Enemy

@export_group("Speed")
@export var h_speed = 0
@export var v_speed = 0
@export var dead: bool
@onready var ray_cast_2d = $Raycast
@onready var animated_sprite_2d = $Sprite

func _process(delta: float) -> void:
	position.x -= h_speed * delta
	if !ray_cast_2d.is_colliding():
		self.position.y += v_speed * delta

func _die():
	h_speed = 0
	v_speed = 0
	dead = true
	animated_sprite_2d.play("dead")

func _die_from_hit():
	h_speed = 0
	v_speed = 0
	dead = true
	rotation_degrees = 180
	
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	
	var dead_tween = get_tree().create_tween()
	dead_tween.tween_property(self, "position", position + Vector2(0, -25), 0.2)
	dead_tween.chain().tween_property(self, "position", position + Vector2(0, 500), 4)
