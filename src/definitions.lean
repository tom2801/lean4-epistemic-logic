set_option autoImplicit false
-- Definition of a formula in modal logic

-- epstemic logic extends basic modal logic,
-- and in this case the box operator is read as "it is known that"

inductive formula where
| atomic_prop: Char → formula
| not: formula → formula
| implication: formula → formula → formula
| box: Nat → formula → formula -- de introdus nat ca sa fac logica multimodala


-- p → □q
#check formula.implication (formula.atomic_prop 'p') (formula.box 1 (formula.atomic_prop 'q'))


-- since using the constructors of the formula type can be quite verbose,
-- we introduce the following notations

-- Implement alternative symbols for operators

def prop (c : Char) : formula := formula.atomic_prop c
prefix:80 "~" => formula.not
prefix:70 "K" => formula.box
infix:50 "↣" => formula.implication

#check (K 1) (prop 'p')

-- defining conjunction and disjunction

def form_and (φ  ψ : formula) : formula := ~ (φ ↣ ~ψ)
infix:60 "⋏" => form_and

def form_or (φ  ψ : formula) : formula := (~φ) ↣ ψ
infix:60 "⋎" => form_or


-- de introdus tipuri de tautologie
-- plus de adaugat constrangeri
set_option hygiene false in prefix:100 "⊢S5" => S5Provable
inductive S5Provable : formula → Prop where
| modusPonens {f g : formula} : ⊢S5 f → ⊢S5 (f ↣ g) → ⊢S5 g
| K_axiom {f g : formula} {i : Nat} : ⊢S5 ((K i) (f ↣ g) ↣ ((K i) f ↣ (K i) g))
| necessitation {f : formula} {i : Nat}: ⊢S5 f → ⊢S5 (K i) f
