extends Node2D

@onready var speech_bubble_scene = preload("res://scenes/speech_bubble.tscn")
@onready var detailed_speech_bubble_scene = preload("res://scenes/detailed_speech_bubble.tscn")
@onready var plant_scene = preload("res://scenes/plant.tscn")

var plant: Node2D = null

var plant_type: String = ""
var disease: String = ""

var speech_bubble_spawned: bool = false
var plant_assigned: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "walk_forward"
	assign_plant_and_disease()	

func assign_plant_and_disease():
	# Check if a plant was already spawned
	if plant_assigned:
		return
	
	#List of dictionaries defining possible plants and their associated diseases
	var plant_data = [
		{"plant" : "Tomato", "disease": ["Spiders", "Aphids"]},
	]
	
	var selected_plant = plant_data[randi() % plant_data.size()] # Randomizer 
	plant_type = selected_plant["plant"] # Extract plant type
	disease = selected_plant["disease"][randi() % selected_plant["disease"].size()] # Extract possible disease
	
	print("Selected plant: " + plant_type + ", Disease: " + disease) 
	
	#Call the custom method after instantiating the plannt into the scene
	plant = plant_scene.instantiate()
	get_parent().add_child(plant)
	plant.set_plant_data(plant_type, disease) # Set the corresponding sprite to the chosen combo
	plant_assigned = true

# Area2D handles input interactions
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.pressed:
		
		if not speech_bubble_spawned:
			spawn_speech_bubble()
		
# Spawn the speech bubble with the correct sprite		
func spawn_speech_bubble():
	var speech_bubble = speech_bubble_scene.instantiate()
	add_child(speech_bubble)
	
	# Pass the data to the speech bubble
	speech_bubble.set_speech_bubble_data(plant_type, disease)
	
	# Dynamically connect the signal from the speech bubble
	speech_bubble.connect("info_button_pressed", Callable(self, "_on_info_button_pressed"))

	print("Displaying speech bubble for plant: %s with disease: %s" % [plant_type, disease])
	speech_bubble_spawned = true

	
# Spawn the detailed speech bubble when the info button is pressed
func _on_info_button_pressed():
	print("Info button pressed, spawning detailed speech bubble for plant: %s, disease: %s" % [plant_type, disease])

	# Remove or hide the speech bubble
	var speech_bubble = get_node_or_null("SpeechBubble")  # Adjust the node name if needed
	if speech_bubble:
		speech_bubble.queue_free()

	# Spawn the detailed speech bubble
	var detailed_speech_bubble = detailed_speech_bubble_scene.instantiate()
	add_child(detailed_speech_bubble)

	# Pass the data explicitly
	detailed_speech_bubble.set_detailed_speech_bubble_data(plant_type, disease)	
