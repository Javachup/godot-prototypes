class_name Wall
extends Polygon2D

@onready var collision_shape_2d = %CollisionShape2D

func _ready():
	collision_shape_2d.shape.points = polygon
