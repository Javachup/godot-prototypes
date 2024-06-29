class_name Track
extends Path2D

@onready var button = %Button

@export var note:PackedScene
@export_range(0,1) var button_position := 0.9
@export var input_name:String
@export var note_speed := 200.0

var path_length:float :
	get: return curve.get_baked_length() * button_position

var path_time:float :
	get: return path_length / note_speed

var notes:Array[Note] = []

signal note_hit(intended_beat)
signal note_missed(intended_beat)

func _ready():
	button.progress_ratio = button_position

func spawn_note(beat:int):
	var temp = note.instantiate() as Note
	temp.path_length = path_length
	temp.on_path_end.connect(_note_missed)

	print(path_time)
	temp.time_to_end = path_time
	temp.intended_beat = beat

	add_child(temp)
	notes.push_front(temp)

func _note_missed():
	var temp = notes.pop_back()
	note_missed.emit(temp.intended_beat)

func _unhandled_input(event):
	if event.is_action_pressed(input_name):
		var temp = notes.pop_back()
		if temp == null:
			return
		note_hit.emit(temp.hit())
