/- Lean4 Exercises for Week 2. -/

import Mathlib

/- Define a function that adds 3 to an natural number. -/
def add_three : ℕ → ℕ := fun n => 3 + n

#eval add_three 0  /- 3 -/
#eval add_three 1  /- 4 -/
#eval add_three 10  /- 13 -/

/- Define a function that subtracts 1 from an integer. -/
def sub_one : ℤ → ℤ := fun n => (Sub.sub n) 1

#eval sub_one 0  /- -1 -/
#eval sub_one (-1)  /- -2 -/
#eval sub_one 5  /- 4 -/

/- Define a function that subtracts an integer from 1. -/
def one_sub : ℤ → ℤ := Sub.sub 1

#eval one_sub 0  /- 1 -/
#eval one_sub (-1)  /- 2 -/
#eval one_sub 5  /- -4 -/

/- Bonus: can you define the first and third functions above without using `fun`? -/

/- Define a function `applyAndAdd` that takes a function and two natural numbers,
applies the function to the first natural number, and adds the result to the second
natural number.
No stub is provided; you must state the type of `applyAndAdd` yourself. -/

def applyAndAdd : (ℕ → ℕ) → ℕ → ℕ → ℕ := Function.comp Add.add

#eval applyAndAdd (fun n => 3 * n ^ 2) 2 5 /- 17 -/

/- Prove the following two theorems. Above each theorem, add a documentation comment
like the one provided for `triv` below explaining what the theorem proves logically. -/

/-- This theorem is trivial. It proves "True", which logically should be trivial,
and indeed the proof for "True" already exists in Lean 4.
That proof, a term of type `True`, is named `True.intro`. -/
theorem triv : True := True.intro

/-- This theorem says that `a` implies `a`, for all propositions `a`. -/
theorem ident {a : Prop} (t : a) : a := t

/-- This theorem says that implication is transitive, i.e. for all propositions
`a, b, c`, if `a → b`, and if `b → c`, then `a → c`. -/
theorem composition {a b c : Prop} (f : a → b) (g : b → c) : a → c :=
    Function.comp g f
