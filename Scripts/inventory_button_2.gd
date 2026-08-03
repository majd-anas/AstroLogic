extends Button

@onready var side_panel: Panel = $"../../../SidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
