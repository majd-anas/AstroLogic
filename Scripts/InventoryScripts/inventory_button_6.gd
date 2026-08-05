extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var maxterms_side_panel: Panel = $"../../../SidePanel/MaxtermsSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	maxterms_side_panel.visible = true
