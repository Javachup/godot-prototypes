class_name Song
extends Resource

@export var name:String
@export var bpm := 100
@export var beats_per_measure := 4
@export var start_delay := 0.0
@export var stream:AudioStream

@export var num_tracks := 2

@export var notes:Array[NoteData] = []
