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

# Read request from Godot
with open(request_path, "r") as f:

    request = json.load(f)

kmap=request["kmap"]

if kmap==4:
    a, b, c, d = symbols("a b c d")

elif kmap==3:
    a, b, c = symbols("a b c")

else:
    a,b=symbols("a b")


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







expression = request["expression"]


print("Expression received:", expression)


expr_string = convert(expression)

print("Converted:", expr_string)


expr = parse_expr(expr_string)



minterms = []


# Generate truth table
if kmap==4:
    for bits in itertools.product([0,1], repeat=4):

        values = {

            a: bits[0],
            b: bits[1],
            c: bits[2],
            d: bits[3]

        }


        if bool(expr.subs(values)):

            number = (
                bits[0]*8 +
                bits[1]*4 +
                bits[2]*2 +
                bits[3]
            )

            minterms.append(number)

elif kmap==3:
    for bits in itertools.product([0,1], repeat=3):

        values = {

            a: bits[0],
            b: bits[1],
            c: bits[2]

        }


        if bool(expr.subs(values)):

            number = (

                bits[0]*4 +
                bits[1]*2 +
                bits[2]
            )

            minterms.append(number)
else:
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