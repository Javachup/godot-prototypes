class_name Cursor
extends Node2D

@export_category("External Refs")
@export var fruit : Fruit :
	get:
		return fruit
	set(value):
		fruit = value
		if sprite:
			sprite.modulate = fruit.color
		_set_scale_children(fruit.radius * 0.01)

@export_group("Internal Refs")
@export var sprite : Sprite2D

func _ready():
	fruit = fruit

func _set_scale_children(new_scale : float):
	for child in get_children():
		if child is Node2D:
			(child as Node2D).scale = Vector2(new_scale, new_scale)
