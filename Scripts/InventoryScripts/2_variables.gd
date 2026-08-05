extends Button

@onready var minterms_side_panel: Panel = $"../.."
@onready var table_2: Label = $"../../Table2"
@onready var table_3: Label = $"../../Table3"
@onready var table_4: Label = $"../../Table4"


func _on_pressed() -> void:
	table_3.visible = false
	table_4.visible = false
	table_2.visible = true
