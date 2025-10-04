/- Leencode -/

/-- A definition of the natural numbers from scratch. -/
inductive N
  | zero : N
  | succ (n : N) : N

/-- Multiply an `N` by two. -/
def N.mul_two : N → N := by sorry

#reduce N.mul_two (N.zero) -- N.zero
#reduce N.mul_two (N.zero).succ -- N.zero.succ.succ
#reduce N.mul_two (N.zero).succ.succ -- N.zero.succ.succ.succ.succ

/-- Divide an `N` by two, rounding down if necessary. -/
def N.div_two : N → N := by sorry

#reduce N.div_two (N.zero) -- N.zero
#reduce N.div_two (N.zero).succ -- N.zero
#reduce N.div_two (N.zero).succ.succ -- N.zero.succ
#reduce N.div_two (N.zero).succ.succ.succ -- N.zero.succ
#reduce N.div_two (N.zero).succ.succ.succ.succ -- N.zero.succ.succ

/-- A definition of lists from scratch. -/
inductive L (α : Type)
  | nil : L α
  | cons (a : α) (as : L α) : L α

/-- Map: given a list `l` of elements of type `α`, and a function `f : α → β`,
define a function. -/

/-- A definition of binary trees from scratch. -/
inductive T (α : Type)
  | nil : T α
  | cons (a : α) (left : T α) (right : T α) : T α

/-- -/
