extends Node

# Centralized data storage
var plant_data = {
	"Tomato": {
		"diseases": ["Spiders", "Aphids"],
		"sprites": {
			"Spiders": "res://assets/art/disease/tomato_spiders.PNG",
			"Aphids": "res://assets/art/disease/tomato_aphids.PNG"
		},
		"detailed_sprites": {
			"Spiders": "res://assets/art/disease/spiders_detail.png",
			"Aphids": "res://assets/art/disease/aphids_detail.png"
		}
	}
}

# Get a random plant and disease combination
func get_random_plant_and_disease() -> Dictionary:
	var plants = plant_data.keys()
	var random_plant = plants[randi() % plants.size()]
	var diseases = plant_data[random_plant]["diseases"]
	var random_disease = diseases[randi() % diseases.size()]
	return {
		"plant": random_plant,
		"disease": random_disease
	}

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
