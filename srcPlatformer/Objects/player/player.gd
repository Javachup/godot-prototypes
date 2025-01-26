class_name Player
extends CharacterBody2D

const JUMP_KEY = KEY_SPACE
const LEFT_KEY = KEY_A
const RIGHT_KEY = KEY_D

@export_group("Player Vars")
@export var speed := 300.0
@export var jump_velocity = 150.0
## Weaker gravity when going up and pressing jump
@export_range(0,1) var gravity_multiplier = 0.4
@export_range(0,1) var accel = 0.4

@onready var coyote_timer = %CoyoteTimer

@onready var starting_pos = position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func die():
	print("Ah!")
	position = starting_pos

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		var grav = gravity
		if velocity.y < 0 and Input.is_key_pressed(JUMP_KEY):
			grav *= gravity_multiplier
		velocity.y += grav * delta
	else: coyote_timer.start()

	# Handle jump.
	if Input.is_key_pressed(JUMP_KEY) and not coyote_timer.is_stopped():
		velocity.y = -jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var left = float(Input.is_key_pressed(LEFT_KEY))
	var right = float(Input.is_key_pressed(RIGHT_KEY))
	var target_velocity = (right - left) * speed

	velocity.x = lerp(velocity.x, target_velocity, accel)

	move_and_slide()
