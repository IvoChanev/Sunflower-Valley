extends Node2D

# target position to slide to (adjust if needed)
@export var target_position: Vector2

# speed of sliding
@export var slide_speed: float = 5

# flag to determine if the object should move
var is_sliding: bool = false
var slided: bool = false

# opening the book
@export var bookImage: Sprite2D 

func _ready():
	#connect the input event
	set_process(true)

func _process(delta: float) -> void:
	#_go_there(delta)
	return

func _go_there(delta):
	if is_sliding and slided == false:
		for i in range(target_position.x):
			bookImage.position += Vector2(-1,0) * slide_speed * delta
	if bookImage.global_position.x < target_position.x:
		is_sliding = false
		slided = true

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			is_sliding = true
