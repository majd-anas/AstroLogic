extends Button

var extending = false
@onready var l: Line2D = $"../Line2D"

var button_center = position + (size / 2)

func _process(delta: float) -> void:
	if extending:
		l.set_point_position(1, get_global_mouse_position())



func _on_pressed() -> void:
	l.clear_points()
	l.add_point(button_center)
	l.add_point(get_global_mouse_position())
	print("in func")
	extending = true
