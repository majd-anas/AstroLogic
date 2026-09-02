extends Control

@onready var display: Label = $panelContainer/VBoxContainer/HBoxContainer5/Panel/Label
@onready var expression: Label = $Panel/Expression

# The problem expression shown to the player, e.g. "AB'+C"
var problem_expression: String = "AB'C+AB"

const PYTHON_EXE := "python3"  # use full path if python3 isn't on PATH
const SCRIPT_REL := "res://python/calc.py"

func _ready() -> void:
	connect_buttons($panelContainer/VBoxContainer)
	display.text = ""
	print(problem_expression)
	expression.text= problem_expression
func connect_buttons(node: Node):
	for child in node.get_children():
		if child is TextureButton:
			child.button_down.connect(_on_button_down.bind(child))
			child.button_up.connect(_on_button_up.bind(child))
			child.mouse_entered.connect(_on_mouse_entered.bind(child))
			child.mouse_exited.connect(_on_mouse_exited.bind(child))
		else:
			connect_buttons(child)
			
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
	else:
		display.text = "Incorrect (try again)"
		print("Expected something equivalent to: ", result["simplified"])

func run_check(problem: String, answer: String) -> Dictionary:
	var request_path := "user://request.json"
	var response_path := "user://response.json"

	var request_data := {
		"expression": problem,
		"answer": answer
	}

	var req_file := FileAccess.open(request_path, FileAccess.WRITE)
	req_file.store_string(JSON.stringify(request_data))
	req_file.close()

	var script_abs := ProjectSettings.globalize_path(SCRIPT_REL)
	var request_abs := ProjectSettings.globalize_path(request_path)
	var response_abs := ProjectSettings.globalize_path(response_path)

	var output: Array = []
	var exit_code := OS.execute(PYTHON_EXE, [script_abs, request_abs, response_abs], output, true)

	print("Python stdout: ", output)

	if exit_code != 0:
		return {"error": "Python script exited with code %d" % exit_code}

	if not FileAccess.file_exists(response_path):
		return {"error": "No response file produced"}

	var resp_file := FileAccess.open(response_path, FileAccess.READ)
	var response_text := resp_file.get_as_text()
	resp_file.close()

	var json := JSON.new()
	var parse_status := json.parse(response_text)
	if parse_status != OK:
		return {"error": "Failed to parse response JSON: %s" % json.get_error_message()}

	return json.data
