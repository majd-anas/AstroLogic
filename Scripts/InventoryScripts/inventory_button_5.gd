extends Button

@onready var side_panel: Panel = $"../../../SidePanel"
@onready var minterms_side_panel: Panel = $"../../../SidePanel/MintermsSidePanel"

func _on_pressed() -> void:
	var children  = side_panel.get_children()
	for c in children:
		c.visible = false
	minterms_side_panel.visible = true
