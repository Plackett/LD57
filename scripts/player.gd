extends CharacterBody2D


const SPEED = 250.0
const JUMP_VELOCITY = -370.0

var hearts = 3

@onready var _animated_sprite: AnimatedSprite2D = $Sprite/green

@export var heartPaths : Array

# Reference to the timer
@onready var jump_height_timer = $JumpHeightTimer

func _on_jump_height_timer_timeout():
	# Checks if the space bar is still being held down
	if !Input.is_action_pressed("ui_accept"): # If Spacebar is not being pressed
		if abs(velocity.y) < 2*abs(get_gravity().y) or abs(velocity.x) < 2*abs(get_gravity().x):
			velocity = 2*get_gravity()
			print("Low Jump")
	else:
		print("Normal Jump")


# This represents the player's inertia.
var push_force = 1000

func _apply_impulses():
	# after calling move_and_slide()
	if get_slide_collision_count() <= 0: return
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_force(c.get_normal() * -push_force)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta
	# rotate due to gravity
	_animated_sprite.rotation = get_gravity().angle() - PI/2

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump_height_timer.start()
		velocity.y = JUMP_VELOCITY * (get_gravity().y/abs(get_gravity().y))
		$jump.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Flip the sprite
	if (direction > 0 and get_gravity().y > 0) or (direction < 0 and get_gravity().y < 0):
		_animated_sprite.flip_h = false
	elif (direction < 0 and get_gravity().y > 0) or (direction > 0 and get_gravity().y < 0):
		_animated_sprite.flip_h = true
		
	# Play animations
	if is_on_floor():
		if abs(direction) <= 0.05:
			_animated_sprite.play("Idle")
		else:
			_animated_sprite.play("Walk")
	else:
		_animated_sprite.play("Jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	_apply_impulses()
	
	if Input.is_action_just_pressed("ui_text_backspace"):
		if _animated_sprite == $Sprite/green:
			_animated_sprite = $Sprite/colorblind
			$Sprite/green.visible = false
			$Sprite/colorblind.visible = true
		else:
			_animated_sprite = $Sprite/green
			$Sprite/green.visible = true
			$Sprite/colorblind.visible = false
			
	if Input.is_key_pressed(KEY_R):
		die()
	
func die():
	up_direction = Vector2.UP
	PhysicsServer2D.area_set_param(get_viewport().find_world_2d().space, PhysicsServer2D.AREA_PARAM_GRAVITY_VECTOR, Vector2.DOWN)
	get_tree().reload_current_scene()
	
func loseHeart():
	if hearts == 1: die()
	hearts = hearts - 1
	if hearts == 2:
		find_child("Camera2D").find_child("Node2D").find_child("HeartOne").texture = load("res://assets/textures/heart_broken.png")
	if hearts == 1:
		find_child("Camera2D").find_child("Node2D").find_child("HeartTwo").texture = load("res://assets/textures/heart_broken.png")
