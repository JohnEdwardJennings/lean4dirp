/- Part 1: Equivalence Relations -/

/--
An **equivalence relation** is a relation (predicate of two variables)
satisfying the properties of reflexivity, symmetry, and transitivity.

The first argument `R` to the constructor (`mk`) is the relation itself,
expressed as a function `ρ → ρ → Prop`.

The remaining arguments are dependent on the first one. They assert that:
* the relation is *reflexive*, meaning that `x` is related to itself;
* the relation is *symmetric*, meaning if `x` is related to `y` then `y` is related to `x`;
* the relation is *transitive*, meaning if `x` is related to `y` and `y` to `z`,
    then `x` is related to `z`.
-/
inductive EquivalenceRelation (ρ : Type) where
    | mk
        (R : ρ → ρ → Prop)
        (refl : ∀ x : ρ, R x x)
        (symm : ∀ x y : ρ, R x y → R y x)
        (trans : ∀ x y z : ρ, R x y → R y z → R x z)
        : EquivalenceRelation ρ

/- Note: to type `ρ`, begin typing "\rho"; to type `∀`, begin typing "\forall".
In general, special characters are typed beginning with a backslash;
often what follows the backslash is the same as it is in LaTeX. -/

/-- An example equivalence relation, based on exact equality. -/
def EqEquiv {α : Type} : EquivalenceRelation α :=
    EquivalenceRelation.mk
        (Eq (α := α))
        (fun x => Eq.refl x)
        (fun x _ hxy => Eq.subst (motive := fun a => Eq a x) hxy (Eq.refl x))
        (fun _ _ _ hxy hyz => Eq.subst hyz hxy)

/- Notes about the above:
* `Eq` is a dependent inductive family (see Theorem Proving in Lean 4, section 7.7).
* `Eq.refl` is the unique constructor of `Eq`.
* `Eq.subst` is a simplified version of the recursor of `Eq`.
To see how these functions are defined, you can always write
`#check Eq.refl` or `#check Eq.subst` and right-click; select
`Go To Definition` from the top of the menu that appears. -/
#check Eq
#check Eq.refl
#check Eq.subst

/-- In this exercise, we will construct an equivalence relation based on a function `f`:
two elements `a, b` of `α` are considered *related*, or equivalent, iff `f a = f b`.
Make sure you understand the previous construction, as this one should
be quite similar. In fact, the above construction is essentially `equivOf id`
(you can `#check id` to see its definition). -/
def equivOf {α β : Type} (f : α → β) : EquivalenceRelation α :=
    EquivalenceRelation.mk
        (fun (a : α) (b : α) => (f a) = (f b))
        (fun (x : α) => Eq.refl (f x))
        (fun (x : α) (y : α) (hxy : (f x) = (f y)) => Eq.symm hxy)
        (fun (x : α) (y : α) (z : α) (hxy : (f x) = (f y))
            (hyz : (f y) = (f z)) => Eq.trans hxy hyz)

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

/-- Define a function from `SumProd α β γ` to `Sum α (Prod β γ)`. -/
noncomputable def forward {α β γ : Type} : SumProd α β γ → Sum α (Prod β γ) :=
    fun p => match p with
    | SumProd.cons1 a => Sum.inl a
    | SumProd.cons2 b c => Sum.inr (b, c)

/-- Define a function from `Sum α (Prod β γ)` to `SumProd α β γ`. -/
noncomputable def backward {α β γ : Type} : Sum α (Prod β γ) → SumProd α β γ :=
    fun p => match p with
    | Sum.inl a => SumProd.cons1 a
    | Sum.inr (b, c) => SumProd.cons2 b c

/-
Because of these relatively natural functions `forward` and `backward`,
we can say that `SumProd α β γ` is equivalent to `Sum α (Prod β γ)`.
In fact, every GADT is equivalent to some (possibly empty) nested sum of
(possibly empty) nested products.
-/

/- Part 3: Natural Numbers. -/

/-- A definition of the natural numbers from scratch. -/
inductive N
  | zero : N
  | succ (n : N) : N

/-- Multiply an `N` by two. -/
def N.mul_two : N → N := fun n => match n with
| zero => n
| succ p => succ (succ (mul_two p))

#reduce N.mul_two (N.zero) -- N.zero
#reduce N.mul_two (N.zero).succ -- N.zero.succ.succ
#reduce N.mul_two (N.zero).succ.succ -- N.zero.succ.succ.succ.succ

/-- Divide an `N` by two, rounding down if necessary. -/
def N.div_two : N → N := fun n => match n with
| zero => zero
| succ zero => zero
| succ (succ p) => (succ (div_two p))

#reduce N.div_two (N.zero) -- N.zero
#reduce N.div_two (N.zero).succ -- N.zero
#reduce N.div_two (N.zero).succ.succ -- N.zero.succ
#reduce N.div_two (N.zero).succ.succ.succ -- N.zero.succ
#reduce N.div_two (N.zero).succ.succ.succ.succ -- N.zero.succ.succ
