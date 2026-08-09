extends CharacterBody2D
@export var dialogue : DialogueDataChar

const SPEED = 50.0
const SIDE_LENGTH = 64.0   # Size of the walk
var current_side = 0
var distance_moved = 0.0
var can_chat=true

var current_state=IDLE
var directions = [
	Vector2.RIGHT,
	Vector2.LEFT
]
var dir=Vector2.RIGHT
var start_pos
var is_roaming=true
var is_chatting=false
enum {IDLE,MOVE}

var player
var player_in_chat_zone=false

func _ready():
	$Timer.wait_time = 2.0
	current_state = IDLE
	DialougeManagerChar.dialogue_finished.connect(_dialogue_finished)

func _dialogue_finished():
	is_chatting = false
	is_roaming = true
	#can_chat=false


func _process(delta):
	if is_roaming:
		match current_state:
		
			IDLE:
				velocity = Vector2.ZERO
				move_and_slide()
				$AnimatedSprite2D.play("idle")
			MOVE:
				move(delta)
				playAnimation(dir)

	if Input.is_action_just_pressed("interact") and can_chat:
		if player_in_chat_zone and !is_chatting :
			print("chatting")
			is_roaming=false
			is_chatting=true
			can_chat=false
			velocity=Vector2.ZERO
			$AnimatedSprite2D.play("idle")
			DialougeManagerChar.start(dialogue)



func choose(array):
	array.shuffle()
	return array.front()
	
func move(delta):
	if is_chatting:
		return

	dir = directions[current_side]

	velocity = dir * SPEED
	move_and_slide()

	distance_moved += SPEED * delta

	if distance_moved >= SIDE_LENGTH:
		distance_moved = 0.0
		current_state = IDLE
		velocity = Vector2.ZERO
		$Timer.start()

func playAnimation(dir):
	if dir.x==0:
		$AnimatedSprite2D.play("idle")
	elif dir.x==-1:
		$AnimatedSprite2D.play("walk_l")
	elif dir.x==1:
		$AnimatedSprite2D.play("walk_r")
	


func _on_chat_detect_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("enter")
		player_in_chat_zone=true


func _on_chat_detect_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("exit")
		player_in_chat_zone=false
		can_chat=true
		


func _on_timer_timeout():
	current_side = (current_side + 1) % directions.size()
	current_state = MOVE
