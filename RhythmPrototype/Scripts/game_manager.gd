extends Node2D

@onready var conductor = %Conductor
@onready var track = $Track
@onready var track_2 = $Track2

@export var song:Song

var temp:Array[Callable] = []
var temp2:Array[float] = []

func _ready():
	temp.append(track.spawn_note)
	temp.append(track_2.spawn_note)
	temp2.append(track.path_time)
	temp2.append(track_2.path_time)
	conductor.load_song(song, temp, temp2)
	conductor.start_song()


func _on_track_note_hit(intended_beat):
	print(intended_beat)
