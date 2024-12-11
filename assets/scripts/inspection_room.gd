extends Node

func _on_move_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
