extends Node2D

@onready var speech_bubble_scene = preload("res://scenes/speech_bubble.tscn")
@onready var detailed_speech_bubble_scene = preload("res://scenes/detailed_speech_bubble.tscn")
@onready var plant_scene = preload("res://scenes/plant.tscn")

var plant: Node2D = null
var plant_type: String = ""
var disease: String = ""
var speech_bubble_spawned: bool = false

func _ready():
	$AnimatedSprite2D.animation = "walk_forward"
	
	# Initialize the target position (can be any Vector2 value)
	target_position = Vector2(200, 750)
	
	assign_plant_and_disease()
	
	# Check if plant has been moved to the Inspection Room
	if PlantManager.is_plant_in_inspection_room:
		# Hide the plant in the Main scene
		hide_plant()
		
# Target position to move the sprite to
var target_position = Vector2()

# Speed at which the sprite moves towards the target position
var speed = 3


func _process(delta):
	move_to_target(delta)

# Function to move the sprite towards the target position
func move_to_target(delta):
	# Update the position using linear interpolation
	position = position.lerp(target_position, speed * delta)

# Retrieve the data from the PlantManager 
# Assign a plant to the client
func assign_plant_and_disease():
	var plant_info = PlantManager.get_random_plant_and_disease()
	plant_type = plant_info.plant
	disease = plant_info.disease
	
	print("Selected plant: %s, Disease: %s" % [plant_type, disease])
	plant = plant_scene.instantiate()
	get_parent().add_child(plant)
	plant.set_plant_data(plant_type, disease)

func hide_plant():
	if plant:
		plant.visible = false
		
# Client interaction
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.pressed and not speech_bubble_spawned:
		spawn_speech_bubble()

# Initial speech bubble spawner
func spawn_speech_bubble():
	var speech_bubble = speech_bubble_scene.instantiate()
	add_child(speech_bubble)
	speech_bubble.set_speech_bubble_data(plant_type, disease)
	speech_bubble.connect("info_button_pressed", Callable(self, "_on_info_button_pressed"))
	speech_bubble_spawned = true

# After the signal is triggered
func _on_info_button_pressed():
	var speech_bubble = get_node_or_null("SpeechBubble")
	if speech_bubble:
		speech_bubble.queue_free()

	var detailed_speech_bubble = detailed_speech_bubble_scene.instantiate()
	add_child(detailed_speech_bubble)
	detailed_speech_bubble.set_detailed_speech_bubble_data(plant_type, disease)
