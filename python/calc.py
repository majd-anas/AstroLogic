import json
import itertools
import sys
from sympy import symbols, Implies
from sympy.parsing.sympy_parser import parse_expr
from sympy.logic.boolalg import simplify_logic, Xor

request_path = sys.argv[1]
response_path = sys.argv[2]

VAR_NAMES = ["a", "b", "c", "d", "e", "f", "x", "y", "z"]
VAR_SYMBOLS = {name: symbols(name) for name in VAR_NAMES}


def find_top_level(s: str, chars: str) -> int:
    """Index of first char in `chars` that is NOT nested inside parens.
    Returns -1 if none found."""
    depth = 0
    for i, ch in enumerate(s):
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        elif depth == 0 and ch in chars:
            return i
    return -1


def resolve_postfix_not(s: str) -> str:
    """Turn postfix ' (NOT) into prefix ~, applying only to the
    single preceding variable OR the matching parenthesized group.
    e.g. "B'"        -> "~B"
         "(A+B)'"    -> "~(A+B)"
         "AB'C"      -> "A~BC"   (implicit-AND regex handles the rest)
    """
    out = []
    i = 0
    while i < len(s):
        ch = s[i]
        if i + 1 < len(s) and s[i + 1] == "'":
            if ch == ")":
                # walk backward to find the matching '('
                depth = 0
                j = i
                while j >= 0:
                    if s[j] == ")":
                        depth += 1
                    elif s[j] == "(":
                        depth -= 1
                        if depth == 0:
                            break
                    j -= 1
                group = s[j:i + 1]
                # remove the group we already emitted into `out`
                already_emitted = "".join(out)
                prefix_len = len(already_emitted) - (len(group) - 1)
                out = list(already_emitted[:prefix_len])
                out.append("~" + group)
            else:
                out.append("~" + ch)
            i += 2  # skip the char and the following '
        else:
            out.append(ch)
            i += 1
    return "".join(out)


def convert(expr: str) -> str:
    """Turn calculator syntax into a sympy-parseable string.

    Precedence (low -> high): < (implication), + (OR),
    . or juxtaposition (AND), ' postfix / ~ prefix (NOT).

    Note: '=' is the submit/check button in the UI, not an expression
    character, so it is never parsed here.
    """
    expr = expr.replace(" ", "").lower()

    idx = find_top_level(expr, "<")
    if idx != -1:
        left = convert(expr[:idx])
        right = convert(expr[idx + 1:])
        return f"Implies({left},{right})"

    expr = resolve_postfix_not(expr)   # handle X' / (X+Y)' -> ~X / ~(X+Y)
    expr = expr.replace("+", "|")      # OR
    expr = expr.replace(".", "&")      # explicit AND

    # implicit AND between adjacent var/paren/not tokens, e.g. "ab", "a(b+c)", "a~b"
    # Zero-width lookaround (not a consuming match) so runs like "abc" get
    # a & inserted at every boundary, not just every other one.
    import re
    expr = re.sub(r"(?<=[a-z0-9)])(?=[a-z(~])", "&", expr)

    return expr


def used_variables(expr) -> list:
    free = {str(s) for s in expr.free_symbols}
    return [v for v in VAR_NAMES if v in free]


def truth_table(expr, var_list):
    minterms = []
    for bits in itertools.product([0, 1], repeat=len(var_list)):
        values = {VAR_SYMBOLS[v]: b for v, b in zip(var_list, bits)}
        if bool(expr.subs(values)):
            number = 0
            for b in bits:
                number = (number << 1) | b
            minterms.append(number)
    return minterms


with open(request_path, "r") as f:
    request = json.load(f)

expression = request["expression"]
user_answer = request.get("answer", None)

print("Expression received:", expression)
expr_string = convert(expression)
print("Converted:", expr_string)

local_dict = {"Implies": Implies}
local_dict.update(VAR_SYMBOLS)

expr = parse_expr(expr_string, local_dict=local_dict)
var_list = used_variables(expr)
simplified_expr = simplify_logic(expr)

response = {
    "variables": var_list,
    "minterms": truth_table(expr, var_list),
    "dontcares": [],
    "simplified": str(simplified_expr),
}

if user_answer is not None and user_answer.strip() != "":
    try:
        user_string = convert(user_answer)
        user_expr = parse_expr(user_string, local_dict=local_dict)
        is_correct = simplify_logic(Xor(expr, user_expr)) == False
        response["correct"] = bool(is_correct)
    except Exception as e:
        response["correct"] = False
        response["parse_error"] = str(e)

with open(response_path, "w") as f:
    json.dump(response, f, indent=4)

print("Response written:")
print(response)