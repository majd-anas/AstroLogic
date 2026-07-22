extends Node2D


@onready var buttons = $Panel2/GridContainer.get_children()
@onready var fountain: AnimatableBody2D = $"../../Fountain"
@onready var timer: Timer = $"../../Timer"
@onready var grid: GridContainer = $Panel2/GridContainer


# K-map cell values
const VAL_0 = "0"
const VAL_1 = "1"
const VAL_X = "X"


# Gray code mapping
const GRAY_CODE_MAP = [
	[0, 1, 3, 2],
	[4, 5, 7, 6],
]


# Game state
var target_minterms: Array[int] = []
var target_dont_cares: Array[int] = []
var player_board: Array = []
func _ready() -> void:
	print("testing collab")
	grid.columns = 4

	var button_index = 0

	for button in buttons:

		button.connect(
			"pressed",
			_on_button_click.bind(button_index, button)
		)

		button_index += 1


	print("Buttons loaded: ", buttons.size())


	reset_game()


	generate_new_problem()


# ==========================
# PYTHON COMMUNICATION
# ==========================


func request_minterms(expression:String):


	# Remove previous response
	if FileAccess.file_exists("user://response.json"):

		DirAccess.remove_absolute(
			ProjectSettings.globalize_path(
				"user://response.json"
			)
		)


	# Create request JSON
	var request_file = FileAccess.open(
		"user://request.json",
		FileAccess.WRITE
	)


	request_file.store_string(
		JSON.stringify(
			{
				"expression": expression,
				"kmap":3
			}
		)
	)


	request_file.close()



	var request_path = ProjectSettings.globalize_path(
		"user://request.json"
	)


	var response_path = ProjectSettings.globalize_path(
		"user://response.json"
	)



	# Start Python
	OS.create_process(
		ProjectSettings.globalize_path("res://python/python.exe"),
		[
			ProjectSettings.globalize_path("res://python/solver.py"),
			request_path,
			response_path
		]
	)


	await wait_for_response()



func wait_for_response():


	while !FileAccess.file_exists(
		"user://response.json"
	):

		await get_tree().create_timer(0.1).timeout


	load_response()


func load_response():

	var file = FileAccess.open(
		"user://response.json",
		FileAccess.READ
	)

	var text = file.get_as_text()

	file.close()


	print("Python response:")
	print(text)


	var data = JSON.parse_string(text)


	if data == null:
		print("JSON parsing failed")
		return


	target_minterms.clear()
	target_dont_cares.clear()


	for m in data["minterms"]:
		target_minterms.append(int(m))


	for x in data["dontcares"]:
		target_dont_cares.append(int(x))


	print("========== K-MAP ANSWER ==========")
	print("Minterms: ", target_minterms)
	print("Don't cares: ", target_dont_cares)
	print("=================================")


	reset_game()

# ==========================
# PROBLEM GENERATION
# ==========================


func generate_new_problem():


	var equations = [

		"a+bc+a(b+c')",

		"ab+c",

		"a'b+c'",

		"ab'+c'",

		"a(b+c)"

	]


	var expression = equations.pick_random()


	print(
		"Equation: ",
		expression
	)



	await request_minterms(expression)



	print(
		"Fill K-map for Σm",
		target_minterms
	)



# ==========================
# GAME LOGIC
# ==========================


func reset_game() -> void:


	player_board = [

		[VAL_0, VAL_0, VAL_0, VAL_0],

		[VAL_0, VAL_0, VAL_0, VAL_0],

	]


	for button in buttons:

		button.get_child(0).text = VAL_0

		button.disabled = false



func _on_button_click(idx:int, button:TextureButton) -> void:


	var row = idx / 4
	var col = idx % 4



	var current_val = player_board[row][col]

	var next_val = VAL_0



	if current_val == VAL_0:

		next_val = VAL_1


	elif current_val == VAL_1:

		next_val = VAL_X


	elif current_val == VAL_X:

		next_val = VAL_0



	player_board[row][col] = next_val

	button.get_child(0).text = next_val



	if check_win():
		hide()
		print(
			"Correct! K-map solved."
		)



func check_win() -> bool:


	for row in range(2):

		for col in range(4):

			var minterm_number = GRAY_CODE_MAP[row][col]

			var player_input = player_board[row][col]



			if minterm_number in target_minterms:


				if player_input != VAL_1:

					return false



			elif minterm_number in target_dont_cares:


				if player_input != VAL_X:

					return false

			else:


				if player_input != VAL_0:

					return false



	return true



func _on_timer_timeout():


	if check_win():

		hide()

		generate_new_problem()
