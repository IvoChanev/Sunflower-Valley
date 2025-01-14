extends Node2D

var plant_type: String = ""
var disease: String = ""

@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node
@onready var sprite_node = $Sprite2D

# Set the plant data and select the correct animation
func set_plant_data(plant: String, disease: String):
	plant_type = plant
	self.disease = disease  # Store plant and disease
	
	var animation_name = "%s_%s" % [plant_type, disease]  # Construct the animation name
	
	if animation_name in animated_sprite.sprite_frames.get_animation_names():
		animated_sprite.play(animation_name)  # Play the matching animation
	else:
		print("Animation not found for: %s" % animation_name)

func mark_as_healed():
	var healthy_sprite_path = PlantManager.get_healthy_sprite(plant_type)
	if healthy_sprite_path != "":
		set_sprite(healthy_sprite_path)
		
func mark_as_killed():
	var dead_sprite_path = PlantManager.get_dead_sprite(plant_type)
	if dead_sprite_path != "":
		set_sprite(dead_sprite_path)
		
func set_sprite(sprite_path: String):
	var texture = load(sprite_path)
	if texture:
		sprite_node.texture = texture  # Apply the sprite to the Sprite2D node
		animated_sprite.visible = false  # Hide the animation when using a static sprite
		sprite_node.visible = true  # Ensure the static sprite is visible
	else:
		print("Failed to load sprite: %s" % sprite_path)
