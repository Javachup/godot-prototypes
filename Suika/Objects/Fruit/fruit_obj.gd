extends Node2D

@export_category("External Refs")
@export var fruit : Fruit

@export_group("Internal Refs")
@export var sprite : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.modulate = fruit.color
	set_scale_children(fruit.radius * 0.01)

func set_scale_children(new_scale : float):
	for child in get_children():
		if child is Node2D:
			(child as Node2D).scale = Vector2(new_scale, new_scale)
