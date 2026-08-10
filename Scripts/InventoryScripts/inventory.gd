extends Control


var is_open : bool = false

func _ready() -> void:
	close()

func _process(delta) -> void:
	if Input.is_action_just_pressed("i") and (QuestManager.is_quest_active("3") or QuestManager.is_quest_completed("3")):
		if QuestManager.is_quest_active("3"):
			QuestManager.complete_quest("3")
		if is_open:
			close()
		else:
			open()

func close() -> void:
	visible = false
	is_open = false

func open() -> void:
	visible = true
	is_open = true
