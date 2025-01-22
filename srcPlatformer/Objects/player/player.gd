extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY = -150.0
const GRAVITY_MULTIPLIER = 0.4

const JUMP_KEY = KEY_SPACE
const LEFT_KEY = KEY_A
const RIGHT_KEY = KEY_D

@onready var coyote_timer = %CoyoteTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		var grav = gravity
		if velocity.y < 0 and Input.is_key_pressed(JUMP_KEY):
			grav *= GRAVITY_MULTIPLIER
		velocity.y += grav * delta
	else: coyote_timer.start()

	# Handle jump.
	if Input.is_key_pressed(JUMP_KEY) and not coyote_timer.is_stopped():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var left = float(Input.is_key_pressed(LEFT_KEY))
	var right = float(Input.is_key_pressed(RIGHT_KEY))
	var direction = right - left
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
