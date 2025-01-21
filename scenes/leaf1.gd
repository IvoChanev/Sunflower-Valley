extends TextureButton

# Adjustable properties
@export var page1: VBoxContainer
@export var page2: VBoxContainer  # The texture to change to on click
@export var book: ScrollContainer

func _on_pressed() -> void:
	if page2:
		page2.visible = true
		# book.move_child(page2, 1)
	page1.visible = false
	print(page1.get_index())
	print(page2.get_index())