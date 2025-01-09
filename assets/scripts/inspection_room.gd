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
		
		# Mark the plant as moved to the Inspection Room
		PlantManager.plant_moved_to_inspection_room()
		
# Go back to the lobby room
func _on_move_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Kill the current plant
func _on_kill_button_pressed() -> void:
	PlantManager.killed_plants_count += 1
	$Plant.mark_as_killed()

# Heal the current plant
func _on_heal_button_pressed() -> void:
	PlantManager.healed_plants_count += 1
	$Plant.mark_as_healed()
	
# End the day
func _on_end_day_button_pressed() -> void:
	var summary = "Day Summary:\n"
	summary += "Healed plants: %d\n" % PlantManager.healed_plants_count
	summary += "Killed plants: %d" % PlantManager.killed_plants_count
		
	print(summary)  # For now, display in the console
	_reset_day()
	
func _reset_day():
	PlantManager.reset_counters()
