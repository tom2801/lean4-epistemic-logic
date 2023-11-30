
-- Definition of a formula in modal logic

-- epstemic logic extends basic modal logic,
-- and in this case the box operator is read as "it is known that"

inductive formula where
| atomic_prop: char → formula
| not: formula → formula
| implication: formula → formula → formula
| box: formula → formula


-- p → □q
#check formula.implication (formula.atomic_prop 'p') (formula.box (formula.atomic_prop 'q'))




-- since using the constructors of the formula type can be quite verbose,
-- we introduce the following notations

def prop (c : char) : formula := formula.atomic_prop c
prefix:80 " ¬ " => formula.not
prefix:70 " □ " => formula.box
infix:50 " → " => formula.implication


#check prop 'p' → □ prop 'q'

-- diamond is the dual operator of box
-- in the context of epistemic logic the diamond operator is read as "it is possible such that"

def diamond (φ : formula) : formula := ¬ (□ ¬ φ)
prefix:70 " ⋄ " => diamond


-- defining conjunction and disjunction

def form_and (φ  ψ : formula) : formula := ¬ (φ → ¬ψ)
infix:60 " ∧ " => form_and

def form_or (φ  ψ : formula) : formula := (¬φ) → ψ
infix:60 " ∨ " => form_or
