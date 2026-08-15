extends CharacterBody2D
@export var initial_dialogue: DialogueDataChar
@export var note_dialogue: DialogueDataChar
@export var inventory_dialogue: DialogueDataChar
@export var terminal_dialogue: DialogueDataChar

signal showMovementHint
signal showTalkingHint
signal hideTalkingHint
signal showNoteHint
signal showInventoryHint
signal showcaseTerminal
signal showTerminalHint
signal hideTerminalHint

const SPEED = 80.0
const SIDE_LENGTH = 150.0   # Size of the walk
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
	print("finished dilaouge sent!")
	if !QuestManager.is_quest_completed("0"):
		emit_signal("showMovementHint")
	
	if QuestManager.is_quest_active("3"):
		emit_signal("showInventoryHint")
	
	if QuestManager.is_quest_active("4"):
		emit_signal("showTerminalHint")
		emit_signal("showcaseTerminal")
	
	#can_chat=false


func _process(delta):
	if QuestManager.is_quest_active("1"):
		introductionScene()
		QuestManager.complete_quest("1")	
		emit_signal("showTalkingHint")
		
	if is_roaming:
		match current_state:
		
			IDLE:
				velocity = Vector2.ZERO
				move_and_slide()
				$AnimatedSprite2D.play("idle")
			MOVE:
				move(delta)
				playAnimation(dir)

	if Input.is_action_just_pressed("interact"):
		if player_in_chat_zone and !is_chatting and can_chat:
			print("chatting")
			is_roaming=false
			is_chatting=true
			can_chat=false
			velocity=Vector2.ZERO
			$AnimatedSprite2D.play("idle")
			DialougeManagerChar.start(get_current_dialogue())
			emit_signal("hideTalkingHint")


func get_current_dialogue() -> DialogueDataChar:

	if QuestManager.is_quest_completed("3"):
		QuestManager.start_quest("4")
		return terminal_dialogue

	if QuestManager.is_quest_completed("2"):
		QuestManager.start_quest("3")
		emit_signal("hideTalkingHint")
		return inventory_dialogue
		
	if QuestManager.is_quest_completed("1"):
		QuestManager.start_quest("2")
		emit_signal("hideTalkingHint")
		emit_signal("showNoteHint")
		return note_dialogue

		
	return initial_dialogue
	
	

	
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
	

	
func introductionScene():
	DialougeManagerChar.start(get_current_dialogue())

	
func _on_chat_detect_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		print("enter")
		player_in_chat_zone=true


func _on_chat_detect_body_exited(body: Node2D) -> void:
	if body.name=="Player":
		print("exit")
		player_in_chat_zone=false
		can_chat=true
		


func _on_timer_timeout():
	current_side = (current_side + 1) % directions.size()
	current_state = MOVE
