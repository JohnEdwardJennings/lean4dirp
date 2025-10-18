/- Leencode -/

/-- A definition of lists from scratch. -/
inductive L (α : Type)
  | nil : L α
  | cons (a : α) (as : L α) : L α

namespace L -- enables the notation `nil`, `cons` instead of `L.nil`, `L.cons`.

/-- **Problem 1: Map**

Given a function `f : α → β` and a list `l` of terms of type `α`,
produce a list of the values of `f` applied to each term of `l` in order. -/
def map {α β : Type} (f : α → β) : L α → L β := fun l =>
  match l with
  | nil => nil
  | cons a as => cons (f a) (map f as)


#eval map (fun (n : Nat) => n + 1) nil -- nil
#eval map (fun (n : Nat) => n + 1) (cons 2 nil) -- cons 3 nil
#eval map (fun (n : Nat) => n + 1) (cons 2 (cons 4 nil)) -- cons 3 (cons 5 nil)
#eval map (fun (n : Nat) => 2 * n + 1) (cons 2 nil) -- cons 5 nil
#eval map (fun (n : Nat) => 2 * n + 1) (cons 2 (cons 4 nil)) -- cons 5 (cons 9 nil)
#eval map (fun (nn : Nat × Nat) => nn.1 + nn.2) (cons (3, 2) (cons (1, 5) nil)) -- cons 5 (cons 6 nil)

/-- **Problem 2: Filter**

Given a predicate `p : α → Bool` and a list `l` of terms of type `α`,
return a list of the terms `a` of the list satisfying `p a`, in order.
-/
def filter {α : Type} (p : α → Bool) : L α → L α := fun l =>
  match l with
  | nil => nil
  | cons a as => if (p a)
      then cons a (filter p as)
      else filter p as

#eval filter (fun n => n < 5) nil -- nil
#eval filter (fun n => n < 5) (cons 4 nil) -- cons 4 nil
#eval filter (fun n => n < 5) (cons 6 nil) -- nil
#eval filter (fun n => n < 5) (cons 4 (cons 6 nil)) -- cons 4 nil
#eval filter (fun (s : String) => s.length < 5) (cons "hello" (cons "lean" (cons "world" nil))) -- cons "lean" nil

/-- **Problem 3: Fold**

Given a function `g : α → β → β` and a list `l` of terms of type `α`,
as well as a starting value `b` of type `β`,
"fold" the elements of the list into a single value of type `β` by
applying `g` repeatedly to the value of type `β`, passing in arguments
of type `α` from the tail to the head.
-/
def foldl {α β : Type} (g : α → β → β) (b : β) : L α → β := fun l =>
  match l with
  | nil => b
  | cons a as => g a (foldl g b as)

#eval foldl Add.add 0 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 10
#eval foldl Mul.mul 1 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 24
#eval foldl (fun a b => 10 * b + a) 0 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 4321
#eval foldl String.append "" (cons "hello " (cons "lean " (cons "world" nil))) -- "hello lean world"

/-- The same as `foldl`, but the elements should be folded in from the
head to the tail. -/
def foldr {α β : Type} (g : α → β → β) (b : β) : L α → β := fun l =>
  match l with
  | nil => b
  | cons a as => foldr g (g a b) as

#eval foldr Add.add 0 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 10
#eval foldr Mul.mul 1 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 24
#eval foldr (fun a b => 10 * b + a) 0 (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- 1234
#eval foldr (fun x y => String.append y x) "" (cons "hello " (cons "lean " (cons "world" nil))) -- "hello lean world"

/-- **Problem 4: Reverse**

Reverse a list in linear time.
Hint: `foldl` and `foldr` operate on the list in reverse order of
each other, and `foldl cons nil` is equal to `id`.
-/
def reverse {α : Type} : L α → L α := foldr cons nil

#eval reverse (cons 1 (cons 2 (cons 3 (cons 4 nil)))) -- cons 4 (cons 3 (cons 2 (cons 1 nil)))
#eval reverse (cons "hello" (cons "lean" (cons "world" nil))) -- cons "world" (cons "lean" (cons "hello" nil))

/-- **Problem 5: Flatten**

Flatten a list of lists into a single list. The resulting list
should contain all the elements of the original list of lists,
in the order as they appear if the nested lists were concatenated
end to end.
-/
def flatten {α : Type} : L (L α) → L α := fun l =>
  match l with
  | nil => nil
  | cons a as =>
    match a with
    | nil => flatten as
    | cons b bs => cons b (flatten (cons bs as))


#eval flatten (α := Nat) nil -- nil
#eval flatten (cons (cons 1 nil) nil) -- cons 1 nil
#eval flatten (cons (cons 1 (cons 2 nil)) nil) -- cons 1 (cons 2 nil)
#eval flatten (cons (cons 1 (cons 2 nil)) (cons (cons 3 nil) nil)) -- cons 1 (cons 2 (cons 3 nil))
#eval flatten (cons (cons 1 nil) (cons (cons 2 (cons 3 (cons 4 nil))) nil)) -- cons 1 (cons 2 (cons 3 (cons 4 nil)))

/-- **Problem 6: Zip**

Given two lists, create a new list consisting of pairs of elements
from those lists, with each element from the first list matched with
the element in the same position in the second list. If one list is
longer than the other, ignore any leftover elements in the longer list.
-/
def zip {α β : Type} : L α → L β → L (α × β) := fun as bs =>
  match as with
  | nil => nil
  | cons a as =>
    match bs with
    | nil => nil
    | cons b bs => cons (a, b) (zip as bs)

#eval zip (cons 1 (cons 2 nil)) (cons 3 (cons 4 nil)) -- cons (1, 3) (cons (2, 4) nil)
#eval zip (cons 1 (cons 2 (cons 3 nil))) (cons 7 (cons 8 (cons 9 nil))) -- cons (1, 7) (cons (2, 8) (cons (3, 9) nil))
#eval zip (cons 0 nil) (cons 1 (cons 2 nil)) -- cons (0, 1) nil
#eval zip (cons 1 (cons 2 nil)) (cons 0 nil) -- cons (1, 0) nil

end L -- close namespace L
