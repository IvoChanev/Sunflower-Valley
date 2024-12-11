extends Node

# Centralized data storage
# Dictionaly holding all the information about plants & diseases and their paths.
var plant_data = {
	"Tomato": {
		"diseases": ["Spiders", "Aphids"],
		"sprites": {
			"Spiders": "res://assets/art/disease/tomato_spiders.png",
			"Aphids": "res://assets/art/disease/tomato_aphids.png"
		},
		"detailed_sprites": {
			"Spiders": "res://assets/art/disease/spiders_detail.png",
			"Aphids": "res://assets/art/disease/aphids_detail.png"
		}
	}
}
	
var current_plant_and_disease = null # Track if plant was already spawned
var is_plant_in_inspection_room = false  # Track if plant is in Inspection Room

#Chose a random plant and a random disease
func get_random_plant_and_disease() -> Dictionary:
	if current_plant_and_disease == null:
		# Generate random plant and disease if not set
		var plants = plant_data.keys()
		var random_plant = plants[randi() % plants.size()]
		var diseases = plant_data[random_plant]["diseases"]
		var random_disease = diseases[randi() % diseases.size()]
		current_plant_and_disease = {
			"plant": random_plant,
			"disease": random_disease
		}
	# Return the plant and disease dictionary
	return current_plant_and_disease

# Get sprite path for a plant-disease combination
func get_sprite(plant: String, disease: String) -> String:
	if plant_data.has(plant) and plant_data[plant]["sprites"].has(disease):
		return plant_data[plant]["sprites"][disease]
	return ""

# Get detailed sprite path
func get_detailed_sprite(plant: String, disease: String) -> String:
	if plant_data.has(plant) and plant_data[plant]["detailed_sprites"].has(disease):
		return plant_data[plant]["detailed_sprites"][disease]
	return ""

# The Inspection room was opened
func plant_moved_to_inspection_room():
	is_plant_in_inspection_room = true;
