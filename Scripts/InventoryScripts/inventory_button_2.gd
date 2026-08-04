extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var or_side_panel: Panel = $"../../../SidePanel/ORSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	or_side_panel.visible = true
