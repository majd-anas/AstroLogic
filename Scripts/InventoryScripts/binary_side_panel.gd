extends Panel
@onready var header: Label = $Header
@onready var header_conversion: Label = $"Header Conversion"
@onready var table_conversion: Label = $"Table Conversion"
@onready var table_binary_to_decimal: Label = $"Table binary to decimal"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on__pressed() -> void:
	header.show()
	header_conversion.hide()
	table_conversion.hide()
	table_binary_to_decimal.show()


func _on__btn2_pressed() -> void:
	header.hide()
	header_conversion.show()
	table_conversion.show()
	table_binary_to_decimal.hide()

	
