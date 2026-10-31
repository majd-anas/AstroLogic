extends Button

var source = null
var incoming_line = null
var expression


func _process(delta: float) -> void:
	if source != null:
		expression = incoming_line.expression
	else:
		expression = text
	print(expression)

func _on_pressed() -> void:
	if CircuitsManager.extending and source == null:
		CircuitsManager.extending = false
		var button_center = global_position + (size / 2)
		CircuitsManager.destination_position = button_center
		CircuitsManager.destination = self
		source = CircuitsManager.source
		incoming_line = CircuitsManager.line
			
