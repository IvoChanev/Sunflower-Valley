extends Control

@onready var disease_sprite = $DiseaseSprite

func set_detailed_speech_bubble_data(plant: String, disease: String):
	var sprite_path = PlantManager.get_detailed_sprite(plant, disease)
	if sprite_path != "":
		disease_sprite.texture = load(sprite_path)
		print("Loaded detailed sprite for %s and %s" % [plant, disease])
	else:
		print("No detailed sprite found for %s and %s" % [plant, disease])
