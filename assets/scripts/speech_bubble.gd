extends Control

signal info_button_pressed

# References
@onready var info_button = $InformationButton
@onready var plant_sprite = $PlantSprite
@onready var detailed_speech_bubble_scene = preload("res://scenes/detailed_speech_bubble.tscn")

var original_speech_bubble: Node = null

# Plant and disease sprites dictionary
var plant_disease_sprites = {
	"Tomato": {
		"Spiders" : "res://assets/art/disease/tomato_spiders.PNG",
		"Aphids" : "res://assets/art/disease/tomato_aphids.PNG"
	}
}

var plant_type: String = ""
var disease: String = ""

func _ready():
	original_speech_bubble = self
	
	# Example: Set plant and disease values (you should update these values dynamically in your actual logic)
	plant_type = "Tomato"
	disease = "Spiders"
	set_speech_bubble_data(plant_type, disease)
	
# Set the sprite for the plant and disease combo
func set_speech_bubble_data(plant: String, disease: String) -> void:
	# Check if the plant and disease exist in the dictionary
	if plant in plant_disease_sprites and disease in plant_disease_sprites[plant]: 
		plant_sprite.texture = load(plant_disease_sprites[plant][disease])  # Retrieve the correct sprite
	else:
		print("No sprite found for plant: %s, disease: %s" % [plant, disease])

func _on_information_button_pressed() -> void:
	print("Info button pressed in speech bubble!")
	emit_signal("info_button_pressed")
