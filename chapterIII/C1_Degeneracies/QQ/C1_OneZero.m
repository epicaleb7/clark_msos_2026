// load "chapterIII/C1_Degeneracies/QQ/C1_OneZero.m";

load "SetupX.m";
load "chapterIII/C1_Degeneracies/QQ/ReduceByA.m";

// ------------------------------------------------------------------
"---------------- Degenerate points along coordinate hyperplanes -------------------------";
// Up to symmetry there are three cases: a = 0 (corner), b = 0 (edge), e = 0 (centre).
// OC = how many components of X meet {x=0} land in each A-orbit, over QQ.
// Over QQ a component can split further over QQbar (compare by_cases_caleb_style, over QQ(zeta8)).

// Case a=0 (corner: a,c,g,i)
ideal := defIdeal + Ideal(a);
"Case a=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByA(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 1 component over QQ (it splits into 4 over QQ(sqrt2, i)): 4 positions x 4 = 16 curves over QQbar.

// Case b=0 (edge: b,d,f,h)
ideal := defIdeal + Ideal(b);
"Case b=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByA(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 4 components over QQ (each splits into 2 over QQ(sqrt2)): 4 positions x 8 = 32 curves over QQbar.

// Case e=0 (centre)
ideal := defIdeal + Ideal(e);
"Case e=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByA(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 8 components over QQ (each splits into 2 over QQ(i)): 1 position x 16 = 16 curves over QQbar.
