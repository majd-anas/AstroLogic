extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed: float = 150.0

var can_move=true
# The direction the player was facing when they stopped moving.
var last_direction := Vector2.DOWN


func _physics_process(_delta):
	if !can_move:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	# Get movement input.
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	# Prevent diagonal movement from being faster.
	if direction.length() > 0:
		direction = direction.normalized()

		velocity = direction * speed

		# Remember the direction we're facing.
		last_direction = direction

		# Play the appropriate walking animation.
		play_walk_animation(direction)
	else:
		velocity = Vector2.ZERO

		# Play the appropriate idle animation.
		play_idle_animation(last_direction)

	move_and_slide()


func play_walk_animation(direction: Vector2):
	var animation_name := ""

	# Mostly vertical movement
	if abs(direction.x) < 0.3:
		if direction.y < 0:
			animation_name = "up"
		else:
			animation_name = "down"

	# Mostly horizontal movement
	elif abs(direction.y) < 0.3:
		if direction.x < 0:
			animation_name = "left"
		else:
			animation_name = "right"

	# Diagonal movement
	else:
		if direction.x < 0 and direction.y < 0:
			animation_name = "leftU"
		elif direction.x < 0 and direction.y > 0:
			animation_name = "leftD"
		elif direction.x > 0 and direction.y < 0:
			animation_name = "rightU"
		elif direction.x > 0 and direction.y > 0:
			animation_name = "rightD"

	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)


func play_idle_animation(direction: Vector2):
	var animation_name := ""

	# Mostly vertical
	if abs(direction.x) < 0.3:
		if direction.y < 0:
			animation_name = "idle_up"
		else:
			animation_name = "idle_down"

	# Mostly horizontal
	elif abs(direction.y) < 0.3:
		if direction.x < 0:
			animation_name = "idle_left"
		else:
			animation_name = "idle_right"

	# Diagonal
	else:
		if direction.x < 0 and direction.y < 0:
			animation_name = "idle_leftU"
		elif direction.x < 0 and direction.y > 0:
			animation_name = "idle_leftD"
		elif direction.x > 0 and direction.y < 0:
			animation_name = "idle_rightU"
		elif direction.x > 0 and direction.y > 0:
			animation_name = "idle_rightD"

	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
