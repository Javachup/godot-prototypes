class_name GameManager
extends Node2D

@export_category("External Refs")
@export var starting_fruit : Fruit

@export_group("Internal Refs")
@export var cursor : Cursor
@export var left_bounds : Node2D
@export var right_bounds: Node2D
@export var fruit_parent : Node2D
@export var fruit_obj : PackedScene

func _ready():
	cursor.fruit = starting_fruit

func _process(delta):
	var cursor_x := get_global_mouse_position().x
	cursor_x = clamp(cursor_x, left_bounds.global_position.x, right_bounds.global_position.x)

	cursor.global_position = Vector2(cursor_x, cursor.global_position.y)

func _unhandled_input(event):
	if event.is_action_pressed("create_fruit"):
		_create_fruit()

func _create_fruit():
	var pos = cursor.global_position

	var new_fruit = fruit_obj.instantiate() as FruitObj
	new_fruit.fruit = starting_fruit
	fruit_parent.add_child(new_fruit)
	new_fruit.global_position = pos

