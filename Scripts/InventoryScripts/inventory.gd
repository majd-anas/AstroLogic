extends Control
signal hideInventroyHint()

var is_open : bool = false

func _ready() -> void:
	close()

func _process(delta) -> void:
	if Input.is_action_just_pressed("i") and (inventoryQuestActive() or invenotryCompletedQuest()):
		if inventoryQuestActive():
			completeActiveQuest()
			emit_signal("hideInventroyHint")
		if is_open:
			close()
		else:
			open()

func inventoryQuestActive()->bool:
	return QuestManager.is_quest_active("3")	||	QuestManager.is_quest_active("5")
	
func invenotryCompletedQuest()->bool:
	return QuestManager.is_quest_completed("3")	||	QuestManager.is_quest_completed("5")
func completeActiveQuest():
	if QuestManager.is_quest_active("3"):
		QuestManager.complete_quest("3")
	if QuestManager.is_quest_active("5"):
		QuestManager.complete_quest("5")
	
func close() -> void:
	visible = false
	is_open = false

func open() -> void:
	visible = true
	is_open = true


func _on_btn1__pressed() -> void:
	pass # Replace with function body.
