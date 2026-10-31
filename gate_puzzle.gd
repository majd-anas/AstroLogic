extends Node2D

@onready var label_2: Label = $Label2
@onready var f: Button = $f

var non_variable: Array = [".","+","\'","(",")"," "]
var variables: Array = []
var brackets: Array = []
var original_expression_translated = ""
var expression2

var variable = ""
func _ready() -> void:
	var original_expression = label_2.text.replace(" ","")
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
		
	print(original_expression_translated)

func _process(delta: float) -> void:
	expression2 = f.expression
	
