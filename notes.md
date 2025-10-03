# Lean 4 Dirp 2025

## Session 1

Lean is a functional language.

term
:   object or value

There is no concept of a statement. There is no such thing as side-effects.

Mathlib is a built-in library in Lean4.

Arguments follow the function name (no parentheses):

```lean
f 1 2
```

Use parentheses to specify precedence.

Defining functions:

```lean
def f : ℕ -> ℕ := fun x => 3 * x
```

Interactive features:

- `#eval` -- evaluate an expression
- `#check` -- get the type of an object

The following function takes a natural as input and returns a function that
takes a natural as input and outputs a boolean.

```lean
def h : ℕ -> ℕ -> Bool := fun x => fun y => x == y
```

If-statements, similar to ternary ops:

```lean
#eval (if (2 > 1) then 24 else 42)
```

Even operators and if-statements are functions. The if-statement is a polymorphic
function.

## Session 2

currying
:   implementing multi-argument functions by having single-argument functions
:   return single-argument functions as many times as necessary

Types in lean are first-class. Functions can take types as inputs and return
types as outputs.

Arrow is right-associative to allow for currying.

Types are themselves instances of type `Type`, which is an instance of `Type 1`,
which is an instance of `Type 2`... These are known as universes.