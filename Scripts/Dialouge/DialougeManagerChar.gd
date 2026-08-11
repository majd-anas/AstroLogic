extends Node

signal dialogue_finished

var current_dialogue : Array[String]
var current_index = 0

var dialogue_box

func _ready() -> void:
	
	await get_tree().process_frame
	
	dialogue_box = get_tree().current_scene.get_node_or_null("UI/DialogueBox")
	
	if dialogue_box:
		dialogue_box.hide()
	else:
		print("DialogueManager: UI/DialogueBox not found.")
	
func start(dialogue_resource):
	current_dialogue = dialogue_resource.dialogue
	current_index = 0

	dialogue_box.show()

	dialogue_box.set_text(
		dialogue_resource.npc_name,
		current_dialogue[current_index]
	)

func next():
	current_index += 1

	if current_index >= current_dialogue.size():
		dialogue_box.hide()
		emit_signal("dialogue_finished")
		return

	dialogue_box.set_text(
		"",
		current_dialogue[current_index]
	)

func _input(event):

	if event.is_action_pressed("interact"):
		next()
