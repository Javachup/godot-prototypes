class_name FruitObj
extends Node2D

@export_category("External Refs")
@export var fruit : Fruit :
	get:
		return fruit
	set(value):
		if value == null:
			printerr("Set fruit to Null!")
			return
		fruit = value
		if sprite: sprite.modulate = fruit.color
		_set_scale_children(fruit.radius * 0.01)

@export_group("Internal Refs")
@export var sprite : Sprite2D

func _ready():
	fruit = fruit

func _on_body_entered(body):
	if body is FruitObj:
		if body.fruit == fruit && fruit.merge_into != null:
			position = lerp(position, body.position, 0.5)
			fruit = fruit.merge_into
			body.free()

func _set_scale_children(new_scale : float):
	for child in get_children():
		if child is Node2D:
			(child as Node2D).scale = Vector2(new_scale, new_scale)
