extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "0"


func _on_pressed() -> void:
	if text == "0":
		text = "1"
	else:
		text = "0"
			
