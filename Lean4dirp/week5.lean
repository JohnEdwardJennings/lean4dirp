/- Part 1: Simple typeclass instances -/

/-- A simple example of a typeclass. Here `M` is a type,
and we want to provide a *monoid* structure on `M` so that
polymorphic functions (and theorems) that expect a Monoid
can apply to `M`.

Mathematically, a monoid is described as a set with a
binary operation that
* is associative;
* has a left identity;
* has a right identity.

See: https://en.wikipedia.org/wiki/Monoid. -/
class Monoid (M : Type) where
  op : M → M → M
  id : M
  lid : ∀ m : M, op id m = m
  rid : ∀ m : M, op m id = m
  assoc : ∀ a b c : M, op (op a b) c = op a (op b c)

/-- The type of natural numbers. -/
inductive N
  | zero : N
  | succ : N → N

namespace N

/- The following exercise shows one possible `Monoid` instance on natural numbers.
There are others (for example, multiplication).
Feel free to define as many helper functions/proofs before the instance as you want. -/

/-- The natural numbers form a monoid under addition. -/
instance : Monoid N where
  op := sorry
  id := sorry
  lid := sorry
  rid := sorry
  assoc := sorry

end N

/- Part 2: Conditional instances -/

/- A lot of Lean's power comes from not only defining instances on specific types,
but defining rules for inferring instances from other instances on related types.
In the exercise, we define three such conditional instances. -/

/-- The type of lists. -/
inductive L (α : Type)
  | nil : L α
  | cons (a : α) (as : L α) : L α

/-- A type is Nontrivial if there exists two distinct members. -/
class Nontrivial (α : Type) where
  x : α
  y : α
  hxy : x ≠ y -- definitionally equal ("defeq") to ¬(x = y), or (x = y) → False

open Nontrivial

/-- A type is Inhabited if it is Nontrivial. -/
instance {α : Type} [Nontrivial α] : Inhabited α where
  default := sorry

namespace L

/-- To prove that certain inductive types are nontrivial, we need a way of showing
that members of the inductive type are only equal if they were created using
the same constructor and equal arguments.
The compiler generates a term noConfusion to enable this reasoning. -/
theorem nil_ne_cons {α : Type} (a : α) (as : L α) : nil ≠ cons a as := L.noConfusion

/-- A list type is nontrivial if the underlying type is inhabited. -/
instance {α : Type} [Inhabited α] : Nontrivial (L α) := sorry

end L

/-- A sum type is nontrivial if both underlying types are inhabited. -/
instance {α β : Type} [Inhabited α] [Inhabited β] : Nontrivial (Sum α β) := sorry


/- Part 3: The Final Boss of Polymorphism -/

/- Instances don't just have to apply to types; they can also apply to
type constructors (functions that take values or other types and return types).
In this exercise, the added polymorphism in the definition means that the
member data and proofs of the instance are polymorphic as well.

As such, if you can successfully navigate this example, you have
truly understood polymorphism in Lean! -/

/--
A *monad* is an instance on a type constructor `M : Type → Type`.

Functional programmers love monads because they enable composing functions
whose return types don't exactly match the next function's argument type but are
related (specifically, the first function produces a `M β` while the next function
consumes a `β`).

Programmers use this to express computations that may fail or have side
effects (or, in the case of `L`, produce multiple values) in a side-effect-free
functional language, chaining successive statements using `fish` and expressing
values in the context of the monad using `pure`.
-/
class MonadData (M : Type → Type) where
  fish {α β γ : Type} : (α → M β) → (β → M γ) → (α → M γ)
  pure {α : Type} : α → M α

/--
In order to expect reasonable behavior from programs, we impose a number
of *laws* on monads, which specify a left and right identity and associativity.

Considering how similar these laws look to the monoid laws, we say:

**A monad is a monoid in the category of endofunctors.**

See: https://james-iry.blogspot.com/2009/05/brief-incomplete-and-mostly-wrong.html. -/
class MonadWithLaws (M : Type → Type) extends MonadData M where
  lid {α β : Type} : ∀ f : α → M β, fish pure f = f
  rid {α β : Type} : ∀ f : α → M β, fish f pure = f
  assoc {α β γ δ : Type} : ∀ (f : α → M β) (g : β → M γ) (h : γ → M δ), fish (fish f g) h = fish f (fish g h)

namespace L

/-- In the exercise, we show an instance of `MonadWithLaws` for `L`.

The three proof members are extremely difficult, so they are optional. If you do not
choose to do them, you can either leave them as `sorry` or change the type
declared below to `MonadData L`.

Hints for `MonadData`:
* You can copy-paste functions from the week 4 Leencode exercise.
* There are two arguments to `fish`. The first one takes a `α` and the second
    one produces a `L γ`, just like the function we wish to construct.
    It almost looks like composition would work, but the link in the middle
    is broken. Is there any way we can transform the second function into
    one that accepts a `L β` instead of a `β`?
* After the transformation, the resulting type might not be exactly equal to `L γ`,
    but is there a way to convert values from the type we get into `L γ`?
 -/
instance : MonadWithLaws L := sorry

end L
