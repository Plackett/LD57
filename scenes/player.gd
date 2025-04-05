extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -370.0

# Reference to the timer
@onready var jump_height_timer = $JumpHeightTimer

func _on_jump_height_timer_timeout():
	# Checks if the space bar is still being held down
	if !Input.is_action_pressed("ui_accept"): # If Spacebar is not being pressed
		if velocity.y < -80:
			velocity.y = -80
			print("Low Jump")
	else:
		print("Normal Jump")


# This represents the player's inertia.
var push_force = 80.0

func _apply_impulses():
	# after calling move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_height_timer.start()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	_apply_impulses()
