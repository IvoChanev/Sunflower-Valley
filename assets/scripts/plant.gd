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
		
		print("Plant: " + plant_type + ", Disease: " + disease)
		
		#Remove all previously added disease sprites
		for child in disease_container.get_children():
				child.queue_free()
			
