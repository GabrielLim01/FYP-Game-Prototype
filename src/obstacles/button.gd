extends Node


# Called when the node enters the scene tree for the first time.
@onready var button_sprite: Sprite2D = $Area2D/Sprite2D
@onready var label: Label = $Area2D/Sprite2D/Label
@export var door: Node2D
@export var time_limit: int
func _ready() -> void:
	button_sprite.texture = load("res://obstacles/button_idle.png")
	label.text = str(time_limit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_enter(body: Node2D) -> void:
	button_sprite.texture = load("res://obstacles/button_pressed.png")
	if not door.is_open:
		door.open()
		for i in range(time_limit,0,-1):
			label.text = str(i)
			await get_tree().create_timer(1.0).timeout
		label.text = str(time_limit)
		door.close()
		


func _on_exit(body: Node2D) -> void:
	button_sprite.texture = load("res://obstacles/button_idle.png")
