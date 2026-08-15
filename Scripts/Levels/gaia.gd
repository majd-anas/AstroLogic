extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var hint: Node2D = $Player/Hint


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	QuestManager.start_quest("0")
	QuestManager.start_quest("1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.velocity!=Vector2.ZERO and !QuestManager.is_quest_completed("0") and hint.visible:
		QuestManager.complete_quest("0")
		hint.hide()


func showHintMovement():
	hint.show()
