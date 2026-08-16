extends Node


# Called when the node enters the scene tree for the first time.
@onready var button_sprite: Sprite2D = $Area2D/Sprite2D
@export var door: Node2D
func _ready() -> void:
	button_sprite.texture = load("res://obstacles/button_idle.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enter(body: Node2D) -> void:
	button_sprite.texture = load("res://obstacles/button_pressed.png")
	if not door.is_open:
		door.open()


func _on_exit(body: Node2D) -> void:
	button_sprite.texture = load("res://obstacles/button_idle.png")
