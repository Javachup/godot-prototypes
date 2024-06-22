class_name Track
extends Path2D

@onready var button = %Button

@export var note:PackedScene
@export_range(0,1) var button_position := 0.9

var notes:Array[Note] = []

func _ready():
	button.progress_ratio = button_position

func spawn_note():
	var temp = note.instantiate() as Note
	temp.path_length = curve.get_baked_length() * button_position
	temp.time_to_end = 2 #TODO: Remove this :)
	notes.append(temp)
	add_child(temp)
