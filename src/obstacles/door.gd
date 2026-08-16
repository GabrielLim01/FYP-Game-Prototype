extends Node2D

@onready var collision_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D

@onready var sprite: Sprite2D = $StaticBody2D/Sprite2D

@export var closed_texture: Texture2D

@export var open_texture: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

var is_open := false

func open() -> void:
	if is_open:
		return
	is_open = true
	sprite.texture = open_texture
	collision_shape.set_deferred("disabled", true)
	# close the door after 10 seconds
	await get_tree().create_timer(5.0).timeout
	close()

func close() -> void:
	if not is_open:
		return
	is_open = false
	sprite.texture = closed_texture
	collision_shape.set_deferred("disabled", false)
