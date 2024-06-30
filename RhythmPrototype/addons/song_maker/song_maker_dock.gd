@tool
extends Control

var track_names:Array[TrackName]
var track_data:Array[TrackData]

@onready var track_names_parent = %TrackNames
@onready var track_data_parent = %TrackData

@onready var file_dialog = %FileDialog
@onready var song_name_edit = %SongNameEdit

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
	var temp = load(path)
	if !(temp is Song):
		printerr("File must be a song resource!")
		return
	song = temp as Song

	song_name_edit.text = song.name
