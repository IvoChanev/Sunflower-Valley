extends Sprite2D


# Adjustable properties
@export var amplitude: float = 10.0  # How far it moves up and down
@export var speed: float = 3.0       # How fast it moves

# Internal variables
var _original_position: Vector2
var _time: float = 0.0

func _ready():
	# Store the sprite's original position
	_original_position = global_position

func _process(delta):
	# Update time
	_time += delta * speed

	# Calculate new y position using a sine wave
	global_position.y = _original_position.y + sin(_time) * amplitude
