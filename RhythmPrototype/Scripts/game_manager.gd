extends Node2D

@onready var conductor = %Conductor
@onready var score_manager = %ScoreManager

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
		track.note_hit.connect(_on_note_hit)
		track.note_missed.connect(_on_note_missed)

	conductor.load_song(song, spawn_note_callbacks, path_times)
	conductor.start_song()

func _on_note_hit(intended_beat):
	score_manager.note_hit()

func _on_note_missed(intended_beat):
	score_manager.note_missed()
