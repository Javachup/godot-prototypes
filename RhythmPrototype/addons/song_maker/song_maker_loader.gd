@tool
extends EditorPlugin

var dock:Control

func _enter_tree():
	dock = preload("res://addons/song_maker/song_maker_dock.tscn").instantiate()

	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, dock)

func _exit_tree():
	remove_control_from_docks(dock)
	dock.free()
