extends Node

@onready var client_scene = preload("res://scenes/client.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() :
	spawn_client()

func spawn_client():
	var client = client_scene.instantiate()
	client.position = Vector2(100, 200)
	add_child(client)
