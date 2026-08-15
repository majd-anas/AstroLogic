extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var hint: Node2D = $Player/Hint
@onready var hint_norella: Node2D = $Norella/HintNorella
@onready var hint_note: Node2D = $Note/HintNote
@onready var hint_inventory: Node2D = $Player/HintInventory
@onready var camera_2d_player: Camera2D = $Player/Camera2D
@onready var hint_terminal: Node2D = $terminal/HintTerminal
@onready var terminal: StaticBody2D = $terminal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.start_quest("0")
	QuestManager.start_quest("1")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.velocity!=Vector2.ZERO and !QuestManager.is_quest_completed("0") and hint.visible:
		QuestManager.complete_quest("0")
		hint.hide()



func showcase_terminal() -> void:
	pause_player()
	var original_position = camera_2d_player.global_position
	var terminal_position = terminal.global_position

	# Move camera to terminal
	var tween = create_tween()
	tween.tween_property(
		camera_2d_player,
		"global_position",
		terminal_position,
		1.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	await tween.finished

	# Stay at terminal for 2 seconds
	await get_tree().create_timer(2.0).timeout

	# Return camera to player
	tween = create_tween()
	tween.tween_property(
		camera_2d_player,
		"global_position",
		original_position,
		1.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	unpause_player()
	
func pause_player():
	player.can_move = false
	player.velocity = Vector2.ZERO

func unpause_player():
	player.can_move = true
	

func showHintMovement():
	hint.show()
	
func showTalkingHint():
	hint_norella.show()

func _on_norella_hide_talking_hint() -> void:
	hint_norella.hide()


func _on_norella_show_note_hint() -> void:
	hint_note.show()


func _on_note_tree_exiting() -> void:
	hint_norella.show()


func _on_norella_show_inventory_hint() -> void:
	hint_inventory.show()


func _on_inventory_hide_inventroy_hint() -> void:
	hint_inventory.hide()
	hint_norella.show()


func _on_norella_show_terminal_hint() -> void:
	hint_terminal.show()
	


func _on_norella_showcase_terminal() -> void:
	showcase_terminal()


func _on_terminal_puzzle_hide_terminal_hint() -> void:
	hint_terminal.hide()
