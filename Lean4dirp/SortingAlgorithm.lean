import Mathlib

open List

/-- The number of elements equal to `e` in the list. -/
def _count (e : ℚ) : List ℚ → ℕ
  | nil => 0
  | cons a as => _count e as + if a = e then 1 else 0

/-- If `a` comes immediately before `b` in the list,
  then `r a b` holds. -/
def forall_adj_pairs (r : ℚ → ℚ → Prop) : List ℚ → Prop
  | nil => True
  | cons _ nil => True
  | cons a (cons b bs) => r a b ∧ forall_adj_pairs r (cons b bs)

/-- The specification for an algorithm
  that sorts lists of rational numbers. -/
structure SortingAlgorithm where
  sort : List ℚ → List ℚ
  count_eq : ∀ as : List ℚ, ∀ e : ℚ, _count e as = _count e (sort as)
  is_sorted : ∀ as : List ℚ, forall_adj_pairs LE.le (sort as)

/-- A similar specification to `SortingAlgorithm`,
  using only definitions from Mathlib.
  Since Mathlib has lots of handy theorems about its
  own definitions, you may find this easier to work with. -/
structure SortingAlgorithmMathlib where
  sort : List ℚ → List ℚ
  count_eq : ∀ as : List ℚ, List.Perm as (sort as)
  is_sorted : ∀ as : List ℚ, List.Pairwise LE.le (sort as)

-- The task for the project is to define a sorting algorithm
-- and prove its correctness.

-- In practice, this means defining
-- a term of type `SortingAlgorithm` or `SortingAlgorithmMathlib`
-- (the two definitions ought to be equivalent; if you wanted to
-- prove this, how would you go about it?).

-- Feel free to base your proof on any sorting algorithm you want
-- (but you will of course have to prove its correctness), and to
-- use any auxiliary helper definitions and theorems you want,
-- including those from Mathlib.
