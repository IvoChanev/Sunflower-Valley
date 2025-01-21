extends Node

# Centralized data storage
# Dictionary holding all the information about plants & diseases and their paths.

var plant_data = {
	"onion": {
		"diseases": ["spiders", "flies", "worms"],
		"sprites": {
			"spiders": "res://assets/art/plants/onion/onion_spiders3.png",
			"flies": "res://assets/art/plants/onion/onion_flies3.png",
			"worms": "res://assets/art/plants/onion/onion_worm3.png"
		},
		"detailed_sprites": {
			"spiders": "res://assets/art/disease/onion/spiders_detail.png",
			"worms": "res://assets/art/disease/onion/worms_detail.png",
			"flies": "res://assets/art/disease/onion/flies_detail.png"
		},
		"healthy" : "res://assets/art/plants/onion/onion_happy.png",
		"dead" : "res://assets/art/plants/onion/onion_dead.png"
	},
	
	"eggplant": {
		"diseases": ["leafmold", "spidermites"],
		"sprites": {
			"leafmold": "res://assets/art/plants/eggplant/eggplant_leafmold.png",
			"spidermites": "res://assets/art/plants/eggplant/eggplant_spidermites.png"
		},
		"detailed_sprites": {
			"leafmold": "res://assets/art/disease/onion/spiders_detail.png",
			"spidermites": "res://assets/art/disease/onion/worms_detail.png"
		},
		"healthy" : "res://assets/art/plants/eggplant/eggplant_happy.png",
		"dead" : "res://assets/art/plants/eggplant/eggplant_dead.png"
	},
	
	"potato": {
		"diseases": ["lateblight", "leafhopper", "virus"],
		"sprites": {
			"lateblight": "res://assets/art/plants/potato/potatoLateBlightded.png",
			"leafhopper": "res://assets/art/plants/potato/potatoleafhopper.png",
			"virus": "res://assets/art/plants/potato/potatoleafhopper.png"
		},
		"detailed_sprites": {
			"lateblight": "res://assets/art/plants/potato/potatoLateBlightded.png",
			"leafhopper": "res://assets/art/plants/potato/potatoleafhopper.png",
			"virus": "res://assets/art/plants/potato/potatoleafhopper.png"
		},
		"healthy": "res://assets/art/plants/potato/potatoxray.png",
		"dead": "res://assets/art/plants/potato/potatoded.png"
	},
	
	"bean": {
		"diseases": ["broadmites", "frogeyeleafspot", "leafhoppers"],
		"sprites": {
			"broadmites": "res://assets/art/plants/bean/Bean_BroadMites_3.png",
			"frogeyeleafspot": "res://assets/art/plants/bean/Bean_FrogEyeLeafSpot_3.png",
			"leafhoppers": "res://assets/art/plants/bean/Bean_Leafhoppers_3.png"
		},
		"detailed_sprites": {
			"broadmites": "res://assets/art/plants/bean/Bean_BroadMites_3.png",
			"frogeyeleafspot": "res://assets/art/plants/bean/Bean_FrogEyeLeafSpot_3.png",
			"leafhoppers": "res://assets/art/plants/bean/Bean_Leafhoppers_3.png"
		},
		"healthy": "res://assets/art/plants/bean/Bean_Healthy.png",
		"dead": "res://assets/art/plants/bean/Bean_Dead.png"
	},
	"tomato": {
		"diseases": ["cercospo", "broadmites"],
		"sprites": {
			"cercospo": "res://assets/art/plants/tomato/TOMATO_CERCOSPORA_2.png",
			"broadmites": "res://assets/art/plants/tomato/TOMATO_SICK_BROAD_MITE_00002.png",
		},
		"detailed_sprites": {
			"cercospo": "res://assets/art/plants/tomato/TOMATO_CERCOSPORA_2.png",
			"broadmites": "res://assets/art/plants/tomato/TOMATO_SICK_BROAD_MITE_00002.png",
		},
		"healthy": "res://assets/art/plants/tomato/TOMATO_HEALTHY_00002.png",
		"dead": "res://assets/art/plants/tomato/TOMATO_DEAD_00002.png"
	}
}
	
var current_plant_and_disease = null # Track if plant was already spawned
var is_plant_in_inspection_room = false  # Track if plant is in Inspection Room

var isDead: bool = false;
var isHealed: bool = false;

var healed_plants_count: int = 0
var killed_plants_count: int = 0

#Reset counters for a new day
func reset_counters():
	healed_plants_count = 0
	killed_plants_count = 0
	
func reset_plant():
	isDead = false;
	isHealed = false;
	current_plant_and_disease = null  # Reset for the next spawn

	
var my_disease

#Choose a random plant and a random disease
func get_random_plant_and_disease() -> Dictionary:
	if current_plant_and_disease == null:
		# Generate random plant and disease if not set
		var plants = plant_data.keys()
		var random_plant = plants[randi() % plants.size()]
		var diseases = plant_data[random_plant]["diseases"]
		var random_disease = diseases[randi() % diseases.size()]
		
		my_disease = random_disease
		
		current_plant_and_disease = {
			"plant": random_plant,
			"disease": random_disease
		}
	# Return the plant and disease 
	return current_plant_and_disease

# Get sprite path for a plant-disease combination
func get_sprite(plant: String, disease: String) -> String:
	if plant_data.has(plant) and plant_data[plant]["sprites"].has(disease):
		return plant_data[plant]["sprites"][disease]
	return ""
	
# Get animation frame paths for a plant-disease combination
func get_animation_frames(plant: String, disease: String) -> Array:
	if plant_data.has(plant) and plant_data[plant].has("animation_frames") and plant_data[plant]["animation_frames"].has(disease):
		return plant_data[plant]["animation_frames"][disease]
	return[]

# Get detailed sprite path
func get_detailed_sprite(plant: String, disease: String) -> String:
	if plant_data.has(plant) and plant_data[plant]["detailed_sprites"].has(disease):
		return plant_data[plant]["detailed_sprites"][disease]
	return ""

# Get the healthy sprite ready	
func get_healthy_sprite(plant: String) -> String:
	if plant_data.has(plant) and plant_data[plant].has("healthy"):
		return plant_data[plant]["healthy"]
	return ""

# Get the dead sprite ready	
func get_dead_sprite(plant: String) -> String:
	if plant_data.has(plant) and plant_data[plant].has("dead"):
		return plant_data[plant]["dead"]
	return ""

# The Inspection room was opened
func plant_moved_to_inspection_room():
	is_plant_in_inspection_room = true;
	
func plant_moved_to_main_room():
	is_plant_in_inspection_room = false;
	
func plant_died():
	isDead = true;
	reset_plant()
	
func plant_healed():
	isHealed = true;
	reset_plant()

	
