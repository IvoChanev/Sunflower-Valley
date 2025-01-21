extends Node2D

var plant_type: String = ""
var disease: String = ""

var isDead: bool = false;
var isHealed: bool = false;

@onready var animated_sprite = $AnimatedSprite2D  # Reference to the AnimatedSprite2D node
@onready var sprite_node = $Sprite2D
@onready var dmg_flash_anim_player = $DmgFlashAnimationPlayer

func _ready():
	if PlantManager.isDead:
		mark_as_killed()
		
		await wait(2)
		PlantManager.reset_plant()
		self.queue_free()
		
	elif PlantManager.isHealed:
		mark_as_healed()
		
		await wait(2)
		PlantManager.reset_plant()
		self.queue_free()
		
# Set the plant data and select the correct animation
func set_plant_data(plant: String, disease: String):
	plant_type = plant
	self.disease = disease  # Store plant and disease
	
	var animation_name = "%s_%s" % [plant_type, disease]  # Construct the animation name
	
	if animation_name in animated_sprite.sprite_frames.get_animation_names():
		animated_sprite.play(animation_name)  # Play the matching animation
	else:
		print("Animation not found for: %s" % animation_name)

func mark_as_healed():
	var healthy_sprite_path = PlantManager.get_healthy_sprite(plant_type)
	if healthy_sprite_path != "":
		set_sprite(healthy_sprite_path)
		
	#sprite_node.position = Vector2(620, 1370)
	sprite_node.scale = Vector2(.2, .2)
		
func take_damage():
	dmg_flash_anim_player.play("dmg_flash")
	
func mark_as_killed():
	
	var dead_sprite_path = PlantManager.get_dead_sprite(plant_type)
	if dead_sprite_path != "":
		set_sprite(dead_sprite_path)
	sprite_node.scale = Vector2(.2, .2)

		
func set_sprite(sprite_path: String):
	var texture = load(sprite_path)
	if texture:
		sprite_node.texture = texture  # Apply the sprite to the Sprite2D node
		animated_sprite.visible = false  # Hide the animation when using a static sprite
		sprite_node.visible = true  # Ensure the static sprite is visible
	else:
		print("Failed to load sprite: %s" % sprite_path)
		
func wait(seconds: float) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = seconds
	timer.one_shot = true
	timer.start()
	await timer.timeout
	timer.queue_free()
	return timer
