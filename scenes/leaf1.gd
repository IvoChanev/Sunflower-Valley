extends TextureButton


# Adjustable properties
@export var page1: VBoxContainer
@export var page2: VBoxContainer  # The texture to change to on click
var change_visibility: bool = false


func _on_pressed() -> void:
	if page2:
		page2.visible = true
	page1.visible = false
