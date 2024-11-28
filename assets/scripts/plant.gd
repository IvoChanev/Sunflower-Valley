extends Node2D

#Hold the data for the plant and its assigned disease
var plant_type: String = ""
var disease: String = ""

#This node contains all the diseases sprites
@onready var disease_container = $Disease

func set_plant_data(plant: String, disease: String):
		#Store plant data
		plant_type = plant
		disease = disease
		#Update plant sprite
		$Sprite.texture = load("res://assets/art/plants/" + plant + ".png")
		
		#Remove all previously added disease sprites
		for child in disease_container.get_children():
				child.queue_free()
		
		var disease_sprite = Sprite2D.new()
		if disease == "Spiders":
			disease_sprite.texture = load("res://assets/art/disease/spiders.png")
		elif disease == "Ants":
			disease_sprite.texture = load("res://assets/art/disease/ants.png")
		elif disease == "Aphids":
			disease_sprite.texture = load("res://assets/art/disease/aphids.png")
			
		disease_container.add_child(disease_sprite)
