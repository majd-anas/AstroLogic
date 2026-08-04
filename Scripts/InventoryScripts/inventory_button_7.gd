extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var binary_side_panel: Panel = $"../../../SidePanel/BinarySidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	binary_side_panel.visible = true
