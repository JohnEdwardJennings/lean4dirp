/- Part 1: Equivalence Relations -/

/--
An **equivalence relation** is a relation (predicate of two variables)
satisfying the properties of reflexivity, symmetry, and transitivity.

The first argument `f` to the constructor (`mk`) is the relation itself,
expressed as a function `ρ → ρ → Prop`.

The remaining arguments are dependent on the first one. They assert that:
* the relation is *reflexive*, meaning that `r` is related to itself;
* the relation is *symmetric*, meaning if `r` is related to `s` then `s` is related to `r`;
* the relation is *transitive*, meaning if `r` is related to `s` and `s` to `t`,
    then `r` is related to `t`.
-/
inductive EquivalenceRelation (ρ : Type) where
    | mk
        (f : ρ → ρ → Prop)
        (refl : ∀ r : ρ, f r r)
        (symm : ∀ r s : ρ, f r s → f s r)
        (trans : ∀ r s t : ρ, f r s → f s t → f r t)
        : EquivalenceRelation ρ

/- Note: to type `ρ`, begin typing "\rho"; to type `∀`, begin typing "\forall".
In general, special characters are typed beginning with a backslash;
often what follows the backslash is the same as it is in LaTeX. -/

/-- An example equivalence relation, based on exact equality. -/
def EqEquiv {α : Type} : EquivalenceRelation α :=
    EquivalenceRelation.mk
        (Eq (α := α))
        (fun r => Eq.refl r)
        (fun r _ hrs => Eq.subst (motive := fun x => Eq x r) hrs (Eq.refl r))
        (fun _ _ _ hrs hst => Eq.subst hst hrs)

/- Notes about the above:
* `Eq` is a dependent inductive type, with a type argument and two arguments of that type.
* `Eq.refl` is the unique constructor of `Eq`.
* `Eq.subst` is a simplified version of the recursor of `Eq`.
To see how these functions are defined, you can always write
`#check Eq.refl` or `#check Eq.subst` and right-click; select
`Go To Definition` from the top of the menu that appears. -/
#check Eq
#check Eq.refl
#check Eq.subst

/-- In the exercise, we will construct an equivalence relation based on a function `f`:
two elements `a, b` of `α` are considered *related*, or equivalent, iff `f a = f b`.
Make sure you understand the previous construction, as this one should
be quite similar. In fact, the above construction is essentially `equivOf id`
(you can `#check id` to see its definition). -/
def equivOf {α β : Type} (f : α → β) : EquivalenceRelation α :=
    EquivalenceRelation.mk
        sorry
        sorry
        sorry
        sorry

/- Part 2: Generalized Algebraic Data Types (GADTs). -/

/- GADTs are inductive types that do not reference themselves in their constructors.
`Sum` and `Prod` are two classes of GADTs in Lean's standard library.
To see how `Sum` and `Prod` are defined, you can always write
`#check Sum` or `#check Prod` and right-click; select
`Go To Definition` from the top of the menu that appears. -/
#check Sum
#check Prod

/-- A `SumProd` is a data structure which either contains a value of type `α` or
two values, of type `β` and `γ` respectively. -/
inductive SumProd (α β γ : Type) where
  | cons1 (a : α) : SumProd α β γ
  | cons2 (b : β) (c : γ) : SumProd α β γ

/-- There is a function from `SumProd α β γ` to `Sum α (Prod β γ)`. -/
noncomputable def forward {α β γ : Type} : SumProd α β γ → Sum α (Prod β γ) :=
    sorry

/-- There is a function from `Sum α (Prod β γ)` to `SumProd α β γ`. -/
noncomputable def backward {α β γ : Type} : Sum α (Prod β γ) → SumProd α β γ :=
    sorry

/-
Because of these relatively natural functions `forward` and `backward`,
we can say that `SumProd α β γ` is equivalent to `Sum α (Prod β γ)`.
In fact, every GADT is equivalent to some (possibly empty) nested sum of
(possibly empty) nested products.
-/
