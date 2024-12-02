extends Node2D

var plant: Node2D = null

var plant_type: String = ""
var disease: String = ""

var speech_bubble_spawned: bool = false
var plant_assigned: bool = false

@onready var speech_bubble_scene = preload("res://scenes/speech_bubble.tscn")
@onready var plant_scene = preload("res://scenes/plant.tscn")

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
		print("Client interacted with!")
		
		if not speech_bubble_spawned:
			spawn_speech_bubble()
		
# Spawn the speech bubble with the correct sprite		
func spawn_speech_bubble():
	var speech_bubble = speech_bubble_scene.instantiate()
	add_child(speech_bubble)
	
	#Pass the data to the speech bubble
	speech_bubble.set_speech_bubble_data(plant_type, disease)
	
	print("Displaying speech bubble for plant: " + plant_type + " with disease: " + disease)
	
	speech_bubble_spawned = true
