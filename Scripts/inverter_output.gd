extends Label

@onready var input_1: Button = $"../Input1"


func _process(delta: float) -> void:
	if input_1.text == "1":
		text = "0"
	else:
		text = "1"
