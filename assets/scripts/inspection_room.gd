extends Node

@onready var plant_scene = preload("res://scenes/plant.tscn")

var plant: Node2D = null
var plant_type: String = ""
var disease: String = ""

func _ready():
	# Get plant and disease from PlantManager
	var plant_info = PlantManager.current_plant_and_disease
	if plant_info != null:
		plant_type = plant_info["plant"]
		disease = plant_info["disease"]
		
		# Instantiate and place the plant in the Inspection room
		plant = plant_scene.instantiate()
		add_child(plant)
		plant.position = Vector2(300, 300)  # Adjust position as needed
		plant.set_plant_data(plant_type, disease)  # Set the plant's data
		
func _on_move_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
