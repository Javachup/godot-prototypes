extends Node2D

@onready var conductor = %Conductor
@onready var score_manager = %ScoreManager
@onready var label = $Label

@export var song:Song
@export var tracks:Array[Track]
@export var eval_text:PackedScene

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
	conductor.start_song(conductor.get_time_of_beat(192))

func _process(delta):
	label.text = "Beat: %d\nTime: %.2f" % [conductor.song_beat_total, conductor.song_time]

func _on_note_hit(track:Track, intended_beat:int):
	var eval = score_manager.note_hit(conductor.get_time_of_beat(intended_beat), conductor.song_time)
	_spawn_eval_text(eval, track.button_position + Vector2.UP * 50)

func _on_note_missed(track:Track, _intended_beat:int):
	var eval = score_manager.note_missed()
	_spawn_eval_text(eval, track.button_position + Vector2.UP * 50)

func _spawn_eval_text(eval_string: String, spawn_pos:Vector2):
	var temp = eval_text.instantiate()
	temp.position = spawn_pos
	(temp.get_child(0) as Label).text = eval_string
	add_child(temp)
