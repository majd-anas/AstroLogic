extends Button

@onready var output: Button = $"../output"
var source = null
var incoming_line = null
var expression

func _ready() -> void:
	text = "0"

func _process(delta: float) -> void:
	if source != null:
		text = source.text
		expression = incoming_line.expression
	else:
		if text != "0" and text != "1":
			text = "0"
		expression = text


func _on_pressed() -> void:
	if not CircuitsManager.extending:
		if text == "0":
			text = "1"
		else:
			text = "0"
	elif CircuitsManager.source != output and source == null:
		text = CircuitsManager.value
		CircuitsManager.extending = false
		var button_center = global_position + (size / 2)
		CircuitsManager.destination_position = button_center
		CircuitsManager.destination = self
		source = CircuitsManager.source
		incoming_line = CircuitsManager.line
			
