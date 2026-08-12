extends Control
@onready var andgate: Node2D = $Panel2/ANDGATE
@onready var orgate: Node2D = $Panel2/ORGATE
@onready var finish_prompt: NinePatchRect = $Panel2/finishPrompt
@onready var inventory: Control = $"../Inventory"
@onready var terminal_puzzle: Control = $"."

var andgate_completed=false
var orgate_completed=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible:	
		if andgate.output=="1":
			andgate_completed=true
			andgate.hide()
			orgate.show()
		if orgate.visible and orgate.output=="1":
			orgate_completed=true
			orgate.hide()
			
		if inventory.visible:
			mouse_filter=Control.MOUSE_FILTER_IGNORE
		else: 
			mouse_filter=Control.MOUSE_FILTER_STOP

	if puzzleCompleted() and QuestManager.is_quest_active("4"):
		finish_prompt.show()
		QuestManager.complete_quest("4")
	
	
	
		

func puzzleCompleted()->bool:
	return orgate_completed and andgate_completed
	

func _on_finish_prompt_pressed() -> void:
	hide()


func _on_close_button_pressed() -> void:
	hide()
