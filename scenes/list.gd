extends VBoxContainer

@export var page1: VBoxContainer
@export var page2: VBoxContainer
@export var page3: VBoxContainer
@export var page4: VBoxContainer
@export var list: VBoxContainer
@export var book: ScrollContainer

func _on_fungal_diseases_pressed() -> void:
	if page1:
		page1.visible = true
		book.move_child(page1, 0)
	list.visible = false


func _on_viral_diseases_pressed() -> void:
	if page2:
		page2.visible = true
		book.move_child(page1, 0)
	list.visible = false


func _on_bacterial_diseases_pressed() -> void:
	if page3:
		page3.visible = true
		book.move_child(page1, 0)
	list.visible = false


func _on_arachnids__insects_pressed() -> void:
	if page4:
		page4.visible = true
		book.move_child(page1, 0)
	list.visible = false
