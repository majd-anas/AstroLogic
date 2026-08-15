extends Node

signal dialogue_finished

var current_dialogue: Array[String]
var current_index = 0
var current_dialogue_resource: DialogueDataChar
var dialogue_box
var player
var dialogue_active=false
func _ready() -> void:
	
	await get_tree().process_frame
	
	dialogue_box = get_tree().current_scene.get_node_or_null("UI/DialogueBox")
	player=get_tree().current_scene.get_node_or_null("Player")
	if dialogue_box:
		dialogue_box.hide()
	else:
		print("DialogueManager: UI/DialogueBox not found.")
	
	
	
func start(dialogue_resource):
	if dialogue_resource == null:
		return
	
	if dialogue_resource.dialogue.is_empty():
		return
	
	dialogue_active = true
	
	pause_player(player)
	current_dialogue_resource = dialogue_resource
	current_dialogue = dialogue_resource.dialogue
	current_index = 0

	dialogue_box.show()

	var npc_name
	if !dialogue_resource.npc_name:
		npc_name = "  "
	else:
		npc_name = dialogue_resource.npc_name
	
	if !dialogue_resource.portrait:
		dialogue_resource.portrait=null
	dialogue_box.set_text(
		npc_name,
		current_dialogue[current_index],
		dialogue_resource.portrait
	)

func next():
	current_index += 1

	if current_index >= current_dialogue.size():
		dialogue_active=false
		dialogue_box.hide()
		emit_signal("dialogue_finished")
		unpause_player(player)
		return

	dialogue_box.set_text(
		"",
		current_dialogue[current_index],
		current_dialogue_resource.portrait
	)
	dialogue_box.set_text(
		"",
		current_dialogue[current_index],
		current_dialogue_resource.portrait
	)



func _input(event):
	if event.is_action_pressed("interact") and dialogue_active:
		next()
		
		
func pause_player(player:CharacterBody2D):
	if player:
		player.set_physics_process(false)
func unpause_player(player:CharacterBody2D):
	if player:
		player.set_physics_process(true)
		
