import json
import itertools
import re
import sys

from sympy import symbols
from sympy.parsing.sympy_parser import parse_expr
from sympy.logic.boolalg import simplify_logic


# Receive paths from Godot
request_path = sys.argv[1]
response_path = sys.argv[2]


a, b = symbols("a b")


def convert(expr):

    expr = expr.replace(" ", "")

    # OR
    expr = expr.replace("+", "|")

    # NOT
    expr = re.sub(
        r"([a-zA-Z])'",
        r"~\1",
        expr
    )

    # implicit AND
    expr = re.sub(
        r'(?<=[a-zA-Z0-9)])(?=[a-zA-Z(~])',
        '&',
        expr
    )
    return expr



# Read request from Godot
with open(request_path, "r") as f:

    request = json.load(f)



expression = request["expression"]


print("Expression received:", expression)


expr_string = convert(expression)

print("Converted:", expr_string)


expr = parse_expr(expr_string)



minterms = []


# Generate truth table
for bits in itertools.product([0,1], repeat=2):

    values = {

        a: bits[0],
        b: bits[1],
    }


    if bool(expr.subs(values)):

        number = (
            bits[0]*2 +
            bits[1]*1
    
        )

        minterms.append(number)



response = {

    "minterms": minterms,

    "dontcares": [],

    "simplified": str(
        simplify_logic(expr)
    )

}



# Send response back to Godot
with open(response_path, "w") as f:

    json.dump(
        response,
        f,
        indent=4
    )


print("Response written:")
print(response)