extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second.

# --- Health & Damage System ---
@export var max_hp: int = 3
var current_hp: int = 3
var is_invulnerable: bool = false

# UI reference (looks for CanvasLayer/HPLabel or CanvasLayer/Label)
@onready var hp_label: Label = get_node_or_null("CanvasLayer/HPLabel")

var last_direction = Vector2(1, 0)

var anim_directions = {
	"idle": [ # list of [animation name, horizontal flip]
		["side_right_idle", false],
		["45front_right_idle", false],
		["front_idle", false],
		["45front_left_idle", false],
		["side_left_idle", false],
		["45back_left_idle", false],
		["back_idle", false],
		["45back_right_idle", false],
	],

	"walk": [
		["side_right_walk", false],
		["45front_right_walk", false],
		["front_walk", false],
		["45front_left_walk", false],
		["side_left_walk", false],
		["45back_left_walk", false],
		["back_walk", false],
		["45back_right_walk", false],
	],
}

func _ready() -> void:
	add_to_group("player")
	current_hp = max_hp
	update_hp_display()

func update_hp_display() -> void:
	if hp_label:
		hp_label.text = "HP: %d / %d" % [current_hp, max_hp]

func take_damage(amount: int) -> void:
	if is_invulnerable or current_hp <= 0:
		return

	current_hp -= amount
	update_hp_display()
	print("Player took damage! Remaining HP: ", current_hp)

	if current_hp <= 0:
		die()
	else:
		# 1-second invulnerability with a red visual flash
		is_invulnerable = true
		modulate = Color(1, 0.3, 0.3)
		await get_tree().create_timer(1.0).timeout
		modulate = Color(1, 1, 1)
		is_invulnerable = false

func die() -> void:
	get_tree().change_scene_to_file("res://game_over.tscn")

func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	motion.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	motion.y /= 2
	motion = motion.normalized() * MOTION_SPEED
	set_velocity(motion)
	move_and_slide()
	var dir = velocity

	if dir.length() > 0:
		last_direction = dir
		update_animation("walk")
	else:
		update_animation("idle")

func update_animation(anim_set):
	var angle = rad_to_deg(last_direction.angle()) + 22.5
	var slice_dir = floor(angle / 45)

	$Sprite2D.play(anim_directions[anim_set][slice_dir][0])
	$Sprite2D.flip_h = anim_directions[anim_set][slice_dir][1]
