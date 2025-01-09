extends Node2D

var plant_type: String = ""
var disease: String = ""

@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node

# Set the plant data and select the correct animation
func set_plant_data(plant: String, disease: String):
	plant_type = plant
	self.disease = disease  # Store plant and disease
	
	var animation_name = "%s_%s" % [plant_type, disease]  # Construct the animation name
	
	if animation_name in animated_sprite.sprite_frames.get_animation_names():
		animated_sprite.play(animation_name)  # Play the matching animation
	else:
		print("Animation not found for: %s" % animation_name)
