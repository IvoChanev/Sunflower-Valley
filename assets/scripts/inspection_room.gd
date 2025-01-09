extends Node

@onready var plant_scene = preload("res://scenes/plant.tscn")
@onready var animation_player = $Blinders/AnimationPlayer
@onready var summary_label = $SummaryLabel

var plant: Node2D = null
var plant_type: String = ""
var disease: String = ""

func _ready():
	summary_label.visible = false
	
	# Get plant and disease from PlantManager
	var plant_info = PlantManager.current_plant_and_disease
	if plant_info != null:
		plant_type = plant_info["plant"]
		disease = plant_info["disease"]
		
		# Instantiate and place the plant in the Inspection room
		plant = plant_scene.instantiate()
		add_child(plant)
		plant.position = Vector2(300, 300)  # Adjust position as needed
		plant.set_plant_data(plant_type, disease)  # Set the plant's data
		
		# Mark the plant as moved to the Inspection Room
		PlantManager.plant_moved_to_inspection_room()
		
# Go back to the lobby room
func _on_move_to_main_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")

# Kill the current plant
func _on_kill_button_pressed() -> void:
	PlantManager.killed_plants_count += 1
	$Plant.mark_as_killed()

# Heal the current plant
func _on_heal_button_pressed() -> void:
	PlantManager.healed_plants_count += 1
	$Plant.mark_as_healed()
	
# End the day 
func _on_end_day_button_pressed() -> void:
	animation_player.play("move_down")
	animation_player.connect("animation_finished", Callable(self, "_on_blinders_animation_finished"))

# Display day resume at the end of the animation
func _on_blinders_animation_finished(animation_name: String):
	if animation_name == "move_down":
		display_day_summary()
		
func display_day_summary():
	var healed = PlantManager.healed_plants_count
	var killed = PlantManager.killed_plants_count
	
	#Make the label visible
	summary_label.visible = true
	summary_label.text = "Day Summary:\nHealed plants: %d\nKilled plants: %d" % [healed, killed]

	var summary = "Day Summary:\n"
	summary += "Healed plants: %d\n" % PlantManager.healed_plants_count
	summary += "Killed plants: %d" % PlantManager.killed_plants_count
		
	print(summary)  # For now, display in the console
	_reset_day()
	
func _reset_day():
	PlantManager.reset_counters()
