extends Button

@onready var l: Line2D = $"../Line2D"
@onready var button_1: Button = $"../Button1"
var button_center = position + (size / 2)


func _on_pressed() -> void:
	button_1.extending = false
	l.set_point_position(1, button_center)
