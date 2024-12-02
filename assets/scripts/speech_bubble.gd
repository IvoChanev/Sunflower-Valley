extends Control

# References
@onready var info_button = $InformationButton
@onready var plant_sprite = $PlantSprite
@onready var detailed_speech_bubble_scene = preload("res://scenes/detailed_speech_bubble.tscn")

var original_speech_bubble: Node = null

var plant_disease_sprites = {
	"Tomato": {
		"Spiders" : "res://assets/art/disease/tomato_spiders.PNG",
		"Aphids" : "res://assets/art/disease/tomato_aphids.PNG"
	}
}

func _ready():
	original_speech_bubble = self
	
func set_speech_bubble_data(plant: String, disease: String) -> void:
	# Check if the plant and disease exist in the dictionary
	if plant in plant_disease_sprites and disease in plant_disease_sprites[plant]: 
		plant_sprite.texture = load(plant_disease_sprites[plant][disease]) # Retrieve the correct sprite
	else:
		print("No sprite found for plant: %s, disease: %s" % [plant, disease])
	
func _on_information_button_pressed() -> void:
	print("Info button pressed!")
	detailed_speech_bubble()
	
func detailed_speech_bubble():
	print("Detailed Speech Bubble Spawned")
	var detailed_speech_bubble = detailed_speech_bubble_scene.instantiate()
	get_parent().add_child(detailed_speech_bubble)
	
	original_speech_bubble.queue_free()
