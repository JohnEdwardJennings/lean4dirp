#eval (1 - 2 : Nat)
#check (1 - 2 : Int)

def name := "Maxim"
def greet (name : String) : String := String.append "Hello, " (String.append name "!")
#eval greet name

def add_ints (a : Int) (b : Int) : Int := a + b
#check add_ints
#check (add_ints)

def volume (height: Nat) (width: Nat) (depth: Nat) : Nat := height * width * depth
#eval volume 10 4 3

def natural_number : Type := Nat
abbrev natural_number_also : Type := Nat

#check Nat × Nat

#check Type 32

#check True.intro
#check True
#check Prop

#check List

#eval (λ x : Nat => x^2) 10

#eval (fun (α : Type) (f : α -> α) (g: α) => f g) Nat (fun x => x + 1) 3
