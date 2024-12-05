extends Control

@onready var disease_sprite = $DiseaseSprite

# Dictionary containing paths to the detailed sprites for plant-disease combinations
var detailed_plant_disease_sprites = {
	"Tomato_Spiders": "res://assets/art/disease/spiders_detail.png",
	"Tomato_Aphids": "res://assets/art/disease/aphids_detail.png"
}

func _ready():
	print("Detailed Speech Bubble ready!")

func set_detailed_speech_bubble_data(plant: String, disease: String):
	print("Setting detailed speech bubble data: Plant - %s, Disease - %s" % [plant, disease])
	
	var sprite_key = "%s_%s" % [plant, disease]
	if detailed_plant_disease_sprites.has(sprite_key):
		var texture = load(detailed_plant_disease_sprites[sprite_key])
		if texture:
			disease_sprite.texture = texture
			print("Texture set successfully for key: %s" % sprite_key)
		else:
			print("Error: Texture not found at path for key: %s" % sprite_key)
	else:
		print("Error: No sprite found for key: %s" % sprite_key)
