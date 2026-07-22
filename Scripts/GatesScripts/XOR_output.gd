extends Label

@onready var input_1: Button = $"../Input1"
@onready var input_2: Button = $"../Input2"


func _process(delta: float) -> void:
	if input_1.text != input_2.text:
		text = "1"
	else:
		text = "0"
