extends CharacterBody2D

@onready var player = $AnimatedSprite2D

const SPEED = 100.0

var previous_direction = Vector2.DOWN

func _physics_process(delta):

	var direction = Input.get_vector("left", "right", "up", "down")

	if direction != Vector2.ZERO:
		previous_direction = direction

		if direction.x < 0:
			player.play("walk_left")
		elif direction.x > 0:
			player.play("walk_right")
		elif direction.y > 0:
			player.play("walk_down")
		elif direction.y < 0:
			player.play("walk_up")
	else:
		if previous_direction.x < 0:
			player.play("idle_left")
		elif previous_direction.x > 0:
			player.play("idle_right")
		elif previous_direction.y > 0:
			player.play("idle_down")
		elif previous_direction.y < 0:
			player.play("idle_up")

	velocity = direction * SPEED
	move_and_slide()
