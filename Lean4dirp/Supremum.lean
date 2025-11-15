import Mathlib

/-- The **supremum** is the least upper bound
of a collection of numbers (here just two
rationals). However, this definition alone
provides no implementation, nor a guarantee
that such a rational number exists for any
particular rationals `a` and `b`. -/
structure Supremum (a b : ℚ) where
  val : ℚ
  ge_a : val ≥ a
  ge_b : val ≥ b
  is_best : ∀ c : ℚ, c ≥ a → c ≥ b → c ≥ val

/-- Fortunately, we *can* always define the
supremum of two rationals, as just the
maximum of the two. -/
def sup2 (a b : ℚ) : Supremum a b where
  val := if a ≥ b then a else b
  ge_a := by
    split -- consider cases a ≥ b, ¬(a ≥ b)
    · exact le_refl a
    · -- split has a bad habit of not naming
      -- its hypotheses; we need to revive `h✝`
      rename_i h
      exact le_of_not_ge h
  ge_b := by
    split
    · rename_i h
      exact h
    · exact le_refl b
  is_best := by
    intro c hca hcb
    split
    all_goals rename_i h
    · exact hca -- here val = a
    · exact hcb -- here val = b
