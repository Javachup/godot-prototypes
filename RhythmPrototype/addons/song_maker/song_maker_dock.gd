@tool
extends Control

const TRACK_DATA_SCENE := preload("res://addons/song_maker/track_data.tscn")
const TRACK_NAME_SCENE := preload("res://addons/song_maker/track_name.tscn")

var track_names:Array[TrackName] = []
var track_data:Array[TrackData] = []

@onready var track_names_parent = %TrackNames
@onready var track_data_parent = %TrackData

@onready var file_dialog = %FileDialog
@onready var song_name_edit = %SongName
@onready var measure_beats_edit = %MeasureBeats
@onready var bpm_edit = %BPM
@onready var start_delay_edit = %StartDelay

var song:Song

func _ready():
	# Set up file dialogue
	file_dialog.current_dir = "res://Resources/Songs"
	file_dialog.add_filter("*.tres", "Song Resources")

func _on_save_button_pressed():
	save()

func save():
	print("Save!")

func _on_load_song_pressed():
	file_dialog.popup()

func _on_file_dialog_file_selected(path):
	# Load song plus some error checks
	var temp = load(path)
	if !(temp is Song):
		printerr("File must be a song resource!")
		return
	song = temp as Song

	# Fill in song info
	song_name_edit.text = song.name
	measure_beats_edit.text = str(song.beats_per_measure)
	bpm_edit.text = str(song.bpm)
	start_delay_edit.text = str(song.start_delay)

	# Create and update every track
	update_tracks()

func update_tracks():
	if song == null:
		printerr("Trying to update tracks with no song!")
		return

	# Clear old tracks
	for item in track_names:
		item.free()
	track_names.clear()
	for item in track_data:
		item.free()
	track_data.clear()

	# Add tracks
	for i in song.track_names.size():
		# Create the track name
		var track_name = TRACK_NAME_SCENE.instantiate()
		track_name.text = song.track_names[i]
		track_names_parent.add_child(track_name)
		track_names.append(track_name)

		# Create the track data
		var track_datum = TRACK_DATA_SCENE.instantiate()
		track_data_parent.add_child(track_datum)
		track_datum.total_beats = int(floor((song.stream.get_length() - song.start_delay) * song.bpm / 60))
		track_datum.beats_per_measure = song.beats_per_measure
		track_datum.update_beats()
		track_data.append(track_datum)

		# Make sure sizes line up
		var size = max(track_name.size.y, track_datum.size.y)
		track_name.custom_minimum_size.y = size
		track_datum.custom_minimum_size.y = size
