extends StaticBody2D
@onready var terminal_puzzle: Control = $"../UI/TerminalPuzzle"
var can_open=false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and QuestManager.is_quest_active("4"):
		if can_open:
			print("here")
			print(terminal_puzzle.visible)
			terminal_puzzle.show()


func _on_open_terminal_area_body_entered(body: Node2D) -> void:
	can_open=true
	print("in area")


func _on_open_terminal_area_body_exited(body: Node2D) -> void:
	can_open=false
	print("out area")
