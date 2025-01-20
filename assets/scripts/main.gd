extends Node

@onready var client_scene = preload("res://scenes/client.tscn")

@onready var plant_scene = preload("res://scenes/plant.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() :
	spawn_client()
	
	if PlantManager.isDead:
		$Plant.mark_as_killed()
		
		await wait(2)
		
		#destroy current client and spawn a new one
		var current_client = $Client
		current_client.queue_free()
		
		await wait(2)
		
		spawn_client()
		
	elif PlantManager.isHealed:
		$Plant.mark_as_healed()
		
		await wait(2)
		
		var current_client = $Client
		current_client.queue_free()
		
		await wait(2)
		
		spawn_client()
		

# Instantiate the client scene
func spawn_client():
	var client = client_scene.instantiate()
	client.position = Vector2(-400, 750)
	add_child(client)
	
# Helper function to create a delay
func wait(seconds: float) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = seconds
	timer.one_shot = true
	timer.start()
	await timer.timeout
	timer.queue_free()
	return timer
