extends MarginContainer

# Array to store the AnimatedSprite2D hearts
@export var hearts: Array[AnimatedSprite2D]

# Health value
var health: int = 3

func _ready():
	# Ensure there are exactly 3 hearts added in the editor
	if hearts.size() != 3:
		push_error("Please assign exactly 3 AnimatedSprite2D nodes to the 'hearts' array.")
		return

func _process(_delta):
	# Check if the "F" key is pressed
	if Input.is_action_just_pressed("ui_left"):  # Replace "ui_accept" with "F" in the input map if necessary
		lose_health()

func lose_health():
	if health > 1:
		# Decrement health
		health -= 1

		# Play the deplete animation on the corresponding heart
		var heart_to_deplete = hearts[health]
		heart_to_deplete.play("health_deplete")  # Play animation without checking
	else:
		SceneTransition.change_scene("res://scenes/main.tscn")
