class_name Wall
extends Polygon2D

@onready var collision_polygon_2d = %CollisionPolygon2D

func _ready():
	collision_polygon_2d.polygon = polygon
