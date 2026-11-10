# Handoff: matching A-summands with sub-group pieces (chapterIV)

## Context
- Thesis (Magma). W = (S/I)_3 · Ω/(a⋯i), dim 111 over Q, variables a..i on a 3×3 grid.
- Big group A = C29mC2 ⋊ D4, built in `chapterIV/_ConjugacyClasses.m`. C29mC2 = C2^9/⟨all flips⟩ ≅ C2^8,
  with even-weight representatives (`DecomposeC28`). A has 104 classes.
- `chapterIV/D_GModule.m` builds the A-module `diff2Forms` and `summands := Decomposition(diff2Forms)`.
  These are the A-summands, called **D_k** below.
- `chapterIV/D4_only/` is the D4-only version: `D4_C_ComputeMatrices.m` and `D4_D_GModule.m`.
  It gives 84 D4-summands, called **E_l**: 8 X.1, 14 X.2, 14 X.3, 21 X.4, 27 X.5 (labels from `CharacterTable(D4)`).
  The bug (A used where D4 was meant, giving "length 104") is fixed.
- `D4_only/D4_raw_output.tex` is the raw D4 output with \mgrid pictures.
  Page 1 is in Magma's order k; page 2 is sorted by CT label, re-indexed by l.
- A restriction snippet has been tested; the user may have pasted it into `D_GModule.m` after the line `summands := …`.
  It prints the D4 multiplicities of each A-summand.

## Task 1 (do first): C2^8 pieces inside each A-summand
Goal (from JV): write bases of the A-summands so that the symmetry is visible.
Plan: work out which C2^8-pieces (**F**) sit inside each A-summand D_k, and use the F-bases to rebase D_k.
- Restrict `diff2Forms` to the normal subgroup N = emb_C29mC2(C29mC2) and decompose it.
  The F's computed by hand can be checked against this.
- Robustness: when a character of N occurs more than once, Magma's choice of individual F summands is arbitrary.
  So intersect D_k with the whole **N-isotypic component** (the sum of all F's with the same character), not with single F's.
  These intersections are canonical, and their dimensions over D_k should add up to dim D_k.
- All inclusion matrices `Matrix(Morphism(M, diff2Forms))` are in the same 111-dim `monCubics` basis.
  So compare with `RowSpace(...)`, `meet` and `subset`.
- Output: a table D_k → its N-pieces with explicit bases, in the same \mgrid style as `D4_raw_output.tex` (new file or page 3).

## Task 2 (parked): D_k ↔ E_l matching
Same as Task 1, but with D4 in place of N.
Intersect each D_k with each D4-isotypic component of W (sum of the E_l with the same label), not with single E_l.

## Practical notes
- Run from the repo root: `/Applications/Magma/magma -b file.m`. Load paths look like `load "chapterIV/...";`.
- The A scripts and D4 scripts reuse the names `diff2Forms`, `summands`, `CT`, `sol` and `father`.
  If both run in one session, save the D4 results under new names first.
- `i` is a polynomial variable of S. Don't use it as a loop variable outside comprehensions.
- `chapterIV/D_GModule.m` ends with `error '';`. Write test scripts that load `C_ComputeMatrices.m`
  and rebuild `diff2Forms` themselves (about 2 min).
- Files in ~/Downloads can't be read (macOS permissions).

## How the user wants help
- Concise; minimal edits to their code, in their style, with exact old/new lines.
- They want to do the mathematical interpretation themselves. Give computations and raw tables, not conclusions.
- `D4_only/D4_decomposition.tex` holds interpretation (spoilers). Don't point the user to it.
- Thesis due Wed 11 Nov 2026.
