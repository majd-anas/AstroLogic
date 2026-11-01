extends Node2D

@onready var label_2: Label = $Label2
@onready var f: Button = $f

var non_variable: Array = [".","+","\'","(",")"," "]
var variables: Array = []
var brackets: Array = []
var original_expression_translated = ""
var answer

func _ready() -> void:
	var original_expression = label_2.text.replace(" ","")
	var variable = ""
	var i = 0
	while i < original_expression.length():
		if original_expression[i] in non_variable:
			if variable != "" and (variable not in variables):
				variables.append(variable)
			
			if original_expression[i] == "(":
				brackets.push_back(i)
				original_expression_translated += variable + "("
			elif original_expression[i] == ")":
				if i < original_expression.length()-1 and original_expression[i+1] == "\'":
					original_expression_translated = original_expression_translated.insert(brackets[-1],"!")
					i+=1
				original_expression_translated += variable + ")"
				brackets.pop_back()
			
			elif original_expression[i] == ".":
				original_expression_translated += variable + "&&"
			elif original_expression[i] == "+":
				original_expression_translated += variable + "||"
			elif original_expression[i] == "\'":
				original_expression_translated += "!" + variable
			else:
				original_expression_translated += variable + original_expression[i]
			
			variable = ""
		
		else:
			variable += original_expression[i]
		
		i+=1
	
	original_expression_translated += variable
	if variable != "" and variable not in variables:
		variables.append(variable)
		
		
	print(original_expression_translated)	
	print(variables)

func are_expressions_equal(expr_str1: String, expr_str2: String, variable_names: Array) -> bool:
	var e1 = Expression.new()
	var e2 = Expression.new()
	
	var packed_names = PackedStringArray(variable_names)
	
	# Parse both strings
	if e1.parse(expr_str1, packed_names) != OK:
		push_error("Failed to parse Expr 1: " + e1.get_error_text())
		return false
	if e2.parse(expr_str2, packed_names) != OK:
		push_error("Failed to parse Expr 2: " + e2.get_error_text())
		return false
		
	# Generate all true/false combinations based on variable count (2^n combinations)
	var total_combinations = 1 << variable_names.size() # Fast exponentiation (2^n)
	
	for i in range(total_combinations):
		var input_values = []
		
		# Break down the integer 'i' into individual boolean bits
		for j in range(variable_names.size()):
			var bit_value = ((i >> j) & 1) == 1
			input_values.append(bit_value)
			
		# Execute both expressions with the current input matrix
		var res1 = e1.execute(input_values, null)
		var res2 = e2.execute(input_values, null)
		
		# Check for compilation or runtime failures
		if e1.has_execute_failed() or e2.has_execute_failed():
			push_error("Execution failed during truth table mapping.")
			return false
			
		# If they differ on even a single combination, they are not equal
		if res1 != res2:
			return false
			
	return true


func _process(delta: float) -> void:
	answer = f.expression
	print(answer)
	if are_expressions_equal(answer, original_expression_translated,variables) :
		f.modulate = Color("00e300ff")
	else:
		f.modulate = Color("ffffff")
