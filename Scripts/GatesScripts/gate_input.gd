extends Button

@onready var outgoing_line: Line2D = $"../Line2D"
var source = null
var incoming_line = null

func _ready() -> void:
	text = "0"

func _process(delta: float) -> void:
	if source != null:
		text = source.text


func _on_pressed() -> void:
	if not CircuitsManager.extending:
		if text == "0":
			text = "1"
		else:
			text = "0"
	elif not outgoing_line.is_extending:
		text = CircuitsManager.value
		CircuitsManager.extending = false
		var button_center = global_position + (size / 2)
		CircuitsManager.destination_position = button_center
		CircuitsManager.destination = self
		source = CircuitsManager.source
		incoming_line = CircuitsManager.line
			
