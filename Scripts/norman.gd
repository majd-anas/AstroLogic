extends CharacterBody2D
@onready var char: AnimatedSprite2D = $AnimatedSprite2D

# Adjust this value in the Inspector to change your speed
@export var speed: float = 300.0

func _physics_process(_delta: float) -> void:
	# 1. Get the direction vector based on your Input Map settings
	var direction := Input.get_vector("left", "right", "up", "down")
	if direction.x < 0: 
		char.flip_h= true
		char.play("Run")
	elif direction.x >0:
		char.flip_h= false
		char.play("Run") 
	elif direction.y < 0:
		char.play("Run")
	elif direction.y > 0:
		char.play("Run")
	else: char.play("Talk")
	velocity = direction * speed
	# 4. Built-in engine function to move the body and handle slide physics
	move_and_slide()
