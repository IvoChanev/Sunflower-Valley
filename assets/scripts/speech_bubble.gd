extends Control

signal info_button_pressed

@onready var info_button = $InformationButton
@onready var plant_sprite = $PlantSprite

var plant_type: String = ""
var disease: String = ""

func _ready():
	set_speech_bubble_data(plant_type, disease)

func set_speech_bubble_data(plant: String, disease: String):
	var sprite_path = PlantManager.get_sprite(plant, disease)
	if sprite_path != "":
		plant_sprite.texture = load(sprite_path)
	else:
		print("No sprite found for plant: %s, disease: %s" % [plant, disease])

# Trigger, no data is being carried
func _on_information_button_pressed():
	emit_signal("info_button_pressed")
