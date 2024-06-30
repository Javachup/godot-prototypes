@tool
extends Control

var track_names:Array[TrackName]
var track_data:Array[TrackData]

@onready var track_names_parent = %TrackNames
@onready var track_data_parent = %TrackData

@onready var file_dialog = %FileDialog
@onready var song_name_edit = %SongName
@onready var measure_beats_edit = %MeasureBeats
@onready var bpm_edit = %BPM
@onready var start_delay_edit = %StartDelay

@onready var test_track = $VBoxContainer/HSplitContainer/ScrollContainer/TrackData/Track


var song:Song

func _ready():
	# Register the already existing nodes
	for child in track_names_parent.get_children():
		track_names.append(child)
	for child in track_data_parent.get_children():
		track_data.append(child)
	# Error check
	if track_data.size() != track_names.size():
		printerr("Tracks do not align!")

	# Make sure the sizes line up
	for i in track_data.size():
		var size = max(track_names[i].size.y, track_data[i].size.y)
		track_names[i].custom_minimum_size.y = size
		track_data[i].custom_minimum_size.y = size

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

	# Set up the beats for each track
	test_track.total_beats = int(floor((song.stream.get_length() - song.start_delay) * song.bpm / 60))
	test_track.beats_per_measure = song.beats_per_measure
	test_track.update_beats()
