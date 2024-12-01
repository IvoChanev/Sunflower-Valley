extends Control

# References
@onready var info_button = $InformationButton
@onready var detailed_speech_bubble_scene = preload("res://scenes/detailed_speech_bubble.tscn")
var original_speech_bubble: Node = null

func _ready():
	original_speech_bubble = self
	
func _on_information_button_pressed() -> void:
	print("Info button pressed!")
	detailed_speech_bubble()
	
func detailed_speech_bubble():
	print("Detailed Speech Bubble Spawned")
	var detailed_speech_bubble = detailed_speech_bubble_scene.instantiate()
	get_parent().add_child(detailed_speech_bubble)
	
	original_speech_bubble.queue_free()
