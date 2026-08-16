extends Control

@onready var display: Label = $panelContainer/VBoxContainer/HBoxContainer5/Panel/Label
@onready var expression: Label = $Expression
@onready var inventory: Control = $"../Inventory"
@onready var timer: Timer = $Timer

signal hideKeypadHint
signal solvedPuzzle
# The problem expression shown to the player, e.g. "AB'+C"
var problem_expression: String = "100101"

const PYTHON_EXE := "python3"  # use full path if python3 isn't on PATH
const SCRIPT_REL := "res://python/calc.py"

func _ready() -> void:
	connect_buttons($panelContainer/VBoxContainer)
	display.text = ""
	print(problem_expression)
	expression.text=problem_expression
	timer.timeout.connect(_on_timer_timeout)
	


func _process(_delta: float) -> void:
	if visible:
		if inventory.visible:
			set_mouse_filter_recursive(self, Control.MOUSE_FILTER_IGNORE)
			print("here")
			pass
		else:
			set_mouse_filter_recursive(self, Control.MOUSE_FILTER_PASS)
			pass
	pass
func connect_buttons(node: Node):
	for child in node.get_children():
		if child is TextureButton:
			child.button_down.connect(_on_button_down.bind(child))
			child.button_up.connect(_on_button_up.bind(child))
			child.mouse_entered.connect(_on_mouse_entered.bind(child))
			child.mouse_exited.connect(_on_mouse_exited.bind(child))
		else:
			connect_buttons(child)

func set_mouse_filter_recursive(node: Node, filter: Control.MouseFilter) -> void:
	if node is Control:
		node.mouse_filter = filter

	for child in node.get_children():
		set_mouse_filter_recursive(child, filter)
		
func on_char_pressed(char: String) -> void:
	display.text += char

func animate_scale(button: TextureButton, target: Vector2):
	var tween = create_tween()
	tween.tween_property(button, "scale", target, 0.08)

func _on_button_down(button):
	animate_scale(button, Vector2(0.9, 0.9))

func _on_button_up(button):
	animate_scale(button, Vector2.ONE)

func _on_mouse_entered(button):
	if !button.button_pressed:
		animate_scale(button, Vector2(1.1, 1.1))

func _on_mouse_exited(button):
	if !button.button_pressed:
		animate_scale(button, Vector2.ONE)
		
func _on_clear_pressed() -> void:
	display.text = ""

func _on_equals_pressed() -> void:
	var user_input := display.text
	var result := run_check(problem_expression, user_input)

	if result.has("error"):
		push_error(result["error"])
		return

	if result.get("correct", false):
		display.text = "Correct!"
		set_puzzle_input(false)
		emit_signal("solvedPuzzle")
		emit_signal("hideKeypadHint")
		
	else:
		display.text = "Incorrect (try again)"
		timer.start()

func run_check(problem: String, answer: String) -> Dictionary:
	return {
		"correct": str(problem.bin_to_int()) == answer
	}
	


func _on_delete_btn_pressed() -> void:
	if display.text.length() > 0:
		display.text = display.text.erase(display.text.length() - 1, 1)


func _on_button_close_pressed() -> void:
	hide()
	
	
func set_puzzle_input(enabled: bool) -> void:
	for child in get_all_buttons(self):
		child.disabled = not enabled

func get_all_buttons(node: Node) -> Array[TextureButton]:
	var buttons: Array[TextureButton] = []

	for child in node.get_children():
		if child is TextureButton:
			buttons.append(child)
		buttons.append_array(get_all_buttons(child))

	return buttons

func _on_timer_timeout() -> void:
	display.text=""
