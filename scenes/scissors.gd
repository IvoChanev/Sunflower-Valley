extends Sprite2D
#@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


# Adjustable properties
@export var new_texture: Texture2D  # The texture to change to on click
@export var room: Node

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if _is_mouse_over():
				_on_sprite_clicked()
				#audio_stream_player_2d.play()

func _is_mouse_over() -> bool:
	# Check if the mouse is over the sprite
	var mouse_pos = get_global_mouse_position()
	return get_rect().has_point(to_local(mouse_pos))

func _on_sprite_clicked():
	# Change the texture when clicked
	if new_texture:
		texture = new_texture
		
		if PlantManager.my_disease == "leafmold":
			room.heal_button()
		elif PlantManager.my_disease == "lateblight":
			room.heal_button()
		elif PlantManager.my_disease == "virus":
			room.heal_button()
		elif PlantManager.my_disease == "frogeyeleafspot":
			room.heal_button()
		elif PlantManager.my_disease == "cercospora":
			room.heal_button()
		else:
			room.kill_button()
		
			
