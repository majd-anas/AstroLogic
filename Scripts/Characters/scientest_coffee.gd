extends CharacterBody2D
@export var dialogue : DialogueDataChar


var is_chatting=false

var player
var player_in_chat_zone=false

func _ready():
	DialougeManagerChar.dialogue_finished.connect(_dialogue_finished)

func _dialogue_finished():
	is_chatting = false

func _process(delta):

	if Input.is_action_just_pressed("interact"):
		if player_in_chat_zone and !is_chatting:
			print("chatting")
			is_chatting=true
			DialougeManagerChar.start(dialogue)



func _on_chat_detect_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("entered")
		player_in_chat_zone=true


func _on_chat_detect_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("exit")
		player_in_chat_zone=false
