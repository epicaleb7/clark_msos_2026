// load "Step2/C1_Degeneracies/QQ zeta8/C1_OneZero.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta8/ReduceByGInQQal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points along coordinate hyperplanes -------------------------";
// Up to symmetry there are three cases: a = 0 (corner), b = 0 (edge), e = 0 (centre).
// OC = how many components of X meet {x=0} land in each G-orbit (over QQal = QQ(zeta8)).
// In the output: zeta_8^2 = i, zeta_8 - zeta_8^3 = sqrt2.

// Case a=0 (corner: a,c,g,i)
ideal := defIdealal + Ideal(a_al);
"Case a=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 4 positions x 4 components = 16 curves in X_{>=1}.

// Case b=0 (edge: b,d,f,h)
ideal := defIdealal + Ideal(b_al);
"Case b=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 4 positions x 8 components = 32 curves.

// Case e=0 (centre)
ideal := defIdealal + Ideal(e_al);
"Case e=0. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 1 position x 16 components = 16 curves.
