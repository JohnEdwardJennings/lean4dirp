import Mathlib

-- This module serves as the root of the `Lean4dirp` library.
-- Import modules here that should be built as part of the library.
import «Lean4dirp».Basic

/- These lines all print "Hello World!". -/
#print "Hello World!"
#reduce "Hello World!"
#eval "Hello World!"

/- This line shows you the type of the string literal "Hello World."
In Lean, strings have type String. -/
#check "Hello World!"
