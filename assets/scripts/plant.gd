extends Node2D

# Hold the data for the plant and its assigned disease
var plant_type: String = ""
var disease: String = ""

# Dictionary which maps all plant-disease combinations
var plant_disease_sprites = {
	"Tomato_Spiders": "res://assets/art/disease/tomato_spiders.PNG",
	"Tomato_Aphids": "res://assets/art/disease/tomato_aphids.PNG" 
}

# This node contains the sprites
@onready var sprite_node = $Sprite2D

# Communicate the picked plant and disease
func set_plant_data(plant: String, disease: String):
		#Store plant data
		plant_type = plant
		disease = disease
		
		print("Plant: " + plant_type + ", Disease: " + disease)
		
		var sprite_key = plant_type + "_" + disease	# Combina plant and disease into a key
		if plant_disease_sprites.has(sprite_key): # Checking key existence
			set_sprite(plant_disease_sprites[sprite_key]) # Retrieve the key's value and set the sprite
		else:
			print("No sprite found for the combo: " + sprite_key)
			
# Set the sprite based on the plant-disease combo
func set_sprite(sprite_path: String):
	var texture = load(sprite_path)
	if texture:
		sprite_node.texture = texture
		
		print("Set sprite for plant-disease combo: " + sprite_path)
	else:
		print("Failed to load sprite: " + sprite_path)
