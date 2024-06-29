extends Node2D

@onready var conductor = %Conductor

@export var song:Song
@export var tracks:Array[Track]

var temp:Array[Callable] = []
var temp2:Array[float] = []

func _ready():
	# Load the tracks
	var spawn_note_callbacks:Array[Callable] = []
	var path_times:Array[float] = []
	for track in tracks:
		spawn_note_callbacks.append(track.spawn_note)
		path_times.append(track.path_time)

	conductor.load_song(song, spawn_note_callbacks, path_times)
	conductor.start_song()

func _on_track_note_hit(intended_beat):
	print(intended_beat)
