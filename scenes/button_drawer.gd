extends Sprite2D


# Adjustable properties
@export var new_texture: Texture2D  # The texture to change to on click

@export var sprite: Sprite2D

var isDrawerOpen: bool = false;

func go_up():
	if sprite:
		sprite.position = Vector2(0, 420)
	else:
		print("Sprite2D not assigned!")

func go_down():
	if sprite:
		sprite.position = Vector2(0, 850)
	else:
		print("Sprite2D not assigned!")

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if _is_mouse_over():
				_on_sprite_clicked()
				

func _is_mouse_over() -> bool:
	# Check if the mouse is over the sprite
	var mouse_pos = get_global_mouse_position()
	return get_rect().has_point(to_local(mouse_pos))

func _on_sprite_clicked():
	# Change the texture when clicked
	if new_texture:
		texture = new_texture
		if isDrawerOpen == false:
			go_up()
			isDrawerOpen = true;
		elif isDrawerOpen == true:
			go_down()
			isDrawerOpen = false
		
