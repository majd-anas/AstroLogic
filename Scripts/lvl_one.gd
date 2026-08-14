extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var move: Node2D = $Hint/Move
@onready var talk_to_norella: Node2D = $Hint/TalkToNorella
@onready var pick_note: Node2D = $Hint/PickNote
@onready var terminal: Node2D = $Hint/Terminal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.start_quest("1")
	QuestManager.start_quest("0")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.velocity!=Vector2.ZERO:
		QuestManager.complete_quest("0")
		move.queue_free()
	if QuestManager.complete_quest("1"):
		talk_to_norella.free()
	if QuestManager.complete_quest("2"):
		pick_note.free()
