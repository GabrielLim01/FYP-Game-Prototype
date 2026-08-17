extends Node2D

@onready var collision_shape: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var sprite: Sprite2D = $StaticBody2D/Sprite2D

@export var closed_texture: Texture2D
@export var open_texture: Texture2D

var is_open := false

func open() -> void:
	if is_open:
		return

	is_open = true
	sprite.texture = open_texture
	collision_shape.set_deferred("disabled", true)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		open()
