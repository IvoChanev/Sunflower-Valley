extends Node2D

var plant_type: String = ""
var disease: String = ""

@onready var sprite_node = $Sprite2D

func set_plant_data(plant: String, disease: String):
	plant_type = plant
	self.disease = disease  # Store the plant and disease
	
	# Instead of using a local dictionary, fetch the sprite path from PlantManager
	var sprite_path = PlantManager.get_sprite(plant_type, disease)
	
	if sprite_path != "":
		set_sprite(sprite_path)  # Set the sprite from PlantManager
	else:
		print("No sprite found for the combo: " + plant_type + "_" + disease)

func set_sprite(sprite_path: String):
	var texture = load(sprite_path)
	if texture:
		sprite_node.texture = texture  # Apply the sprite to the sprite node
	else:
		print("Failed to load sprite: " + sprite_path)
