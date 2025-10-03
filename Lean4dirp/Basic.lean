import Mathlib

#eval (3 * (5 + 6))

def f : ℕ -> ℕ := fun x => 3 * x
def h : ℕ -> ℕ -> Bool := fun x => fun y => x == y

#eval (if (2 > 1) then 24 else 42)
