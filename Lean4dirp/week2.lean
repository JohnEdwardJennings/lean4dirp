/- Lean4 Exercises for Week 2. -/

import Mathlib

/- Define a function that adds 3 to an natural number. -/
def add_three : ℕ → ℕ := fun x => x + 3
def add_three2 (x : ℕ) : ℕ := x + 3

#eval add_three 0  /- 3 -/
#eval add_three 1  /- 4 -/
#eval add_three 10  /- 13 -/
#eval add_three2 0  /- 3 -/
#eval add_three2 1  /- 4 -/
#eval add_three2 10  /- 13 -/

/- Define a function that subtracts 1 from an integer. -/
def sub_one : ℤ → ℤ := fun x => x - 1

#eval sub_one 0  /- -1 -/
#eval sub_one (-1)  /- -2 -/
#eval sub_one 5  /- 4 -/

/- Define a function that subtracts an integer from 1. -/
def one_sub : ℤ → ℤ := fun x => 1 - x
def one_sub2 (x : ℤ) : ℤ := 1 - x

#eval one_sub 0  /- 1 -/
#eval one_sub (-1)  /- 2 -/
#eval one_sub 5  /- -4 -/
#eval one_sub2 0  /- 1 -/
#eval one_sub2 (-1)  /- 2 -/
#eval one_sub2 5  /- -4 -/

/- Bonus: can you define the first and third functions above without using `fun`? -/

/- Define a function `applyAndAdd` that takes a function and two natural numbers,
applies the function to the first natural number, and adds the result to the second
natural number.
No stub is provided; you must state the type of `applyAndAdd` yourself. -/

/- note for later: first (N -> N) is func input, 3rd/4th are nat inputs, last N is output -/
def applyAndAdd : (ℕ → ℕ) → ℕ → ℕ → ℕ := fun x y z => x y + z

#eval applyAndAdd (fun n => 3 * n ^ 2) 2 5 /- 17 -/


/- Prove the following two theorems. Above each theorem, add a documentation comment
like the one provided for `triv` below explaining what the theorem proves logically. -/

/-- This theorem is trivial. It proves "True", which logically should be trivial,
and indeed the proof for "True" already exists in Lean 4.
That proof, a term of type `True`, is named `True.intro`. -/
theorem triv : True := True.intro

/- given the proof of a, which is t, we can prove a by returning
the already given proof in t?? -/
theorem ident {a : Prop} (t : a) : a := t

/- given a, b, and c, and the proof f that a implies b and
the proof g that b implies c, we can prove that a implies c
by taking in proof of a as an input, passing it into f for proof of b,
then passing it into g for proof of c-/
/- also apparently functions are left associative so g f t = (g f) t and doesnt work-/
theorem composition {a b c : Prop} (f : a → b) (g : b → c) : a → c := fun t : a => g (f t)
