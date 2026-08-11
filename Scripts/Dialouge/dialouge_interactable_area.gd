extends Area2D
@export var dialogue: DialogueDataChar
var player_in_chat_zone=false
var is_chatting=false
var can_chat=true
func _ready():
	DialougeManagerChar.dialogue_finished.connect(_dialogue_finished)

func _dialogue_finished():
	is_chatting = false
	#can_chat=false

func _process(delta):

	if Input.is_action_just_pressed("interact"):
		if player_in_chat_zone and !is_chatting and can_chat:
			print("chatting")
			is_chatting=true
			can_chat=false
			DialougeManagerChar.start(dialogue)
			
func _on_body_entered(body: Node2D) -> void:
	if body.name=="Player":
		print("entered")
		player_in_chat_zone=true
		

func _on_body_exited(body: Node2D) -> void:
	if body.name=="Player":
		print("exit")
		player_in_chat_zone=false
		can_chat=true
