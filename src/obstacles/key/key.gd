extends Node

@export var gate: Node2D

@onready var pickup_effect: AnimatedSprite2D = $PickupEffect
@onready var area: Area2D = $Area2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		gate.open()

		area.set_deferred("monitoring", false)
		area.visible = false

		pickup_effect.visible = true
		pickup_effect.play("pickup")

		await pickup_effect.animation_finished

		queue_free()
