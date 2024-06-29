class_name Track
extends Path2D

@onready var button = %Button

@export var note:PackedScene
@export_range(0,1) var button_position := 0.9
@export var input_name:String

var notes:Array[Note] = []

signal note_hit(intended_beat)
signal note_missed(intended_beat)

func _ready():
	button.progress_ratio = button_position

func spawn_note(beat:int):
	var temp = note.instantiate() as Note
	temp.path_length = curve.get_baked_length() * button_position
	temp.on_path_end.connect(_note_missed)

	temp.time_to_end = 2 #TODO: Remove this :)
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
