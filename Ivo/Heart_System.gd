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

func lose_health():

		# Decrement health
		health -= 1

		# Play the deplete animation on the corresponding heart
		var heart_to_deplete = hearts[health]
		heart_to_deplete.play("health_deplete")  # Play animation without checking

		
func plant_dead():
	
	await wait(2)
	SceneTransition.change_scene("res://scenes/main.tscn")
	
func plant_healed():
	
	await wait(2)
	SceneTransition.change_scene("res://scenes/main.tscn")
	
# Helper function to create a delay
func wait(seconds: float) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = seconds
	timer.one_shot = true
	timer.start()
	await timer.timeout
	timer.queue_free()
	return timer
