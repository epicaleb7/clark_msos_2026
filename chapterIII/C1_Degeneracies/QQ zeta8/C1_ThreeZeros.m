// load "Step2/C1_Degeneracies/QQ zeta8/C1_ThreeZeros.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta8/ReduceByGInQQal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with three zero coordinates -------------------------";
// Up to D4 there are 16 cases (D4-orbit sizes add up to 84 = C(9,3)). 13 are empty.
// Each prime in the nonempty cases is a single point (linear equations).

"Empty cases (should all be true):";
"Case {c,d,i}:"; IsProjEmpty(defIdealal + Ideal([c_al, d_al, i_al]));
"Case {a,b,c}:"; IsProjEmpty(defIdealal + Ideal([a_al, b_al, c_al]));
"Case {a,c,f}:"; IsProjEmpty(defIdealal + Ideal([a_al, c_al, f_al]));
"Case {c,g,h}:"; IsProjEmpty(defIdealal + Ideal([c_al, g_al, h_al]));
"Case {b,d,e}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, e_al]));
"Case {d,e,g}:"; IsProjEmpty(defIdealal + Ideal([d_al, e_al, g_al]));
"Case {b,e,i}:"; IsProjEmpty(defIdealal + Ideal([b_al, e_al, i_al]));
"Case {c,d,f}:"; IsProjEmpty(defIdealal + Ideal([c_al, d_al, f_al]));
"Case {b,f,i}:"; IsProjEmpty(defIdealal + Ideal([b_al, f_al, i_al]));
"Case {a,e,g}:"; IsProjEmpty(defIdealal + Ideal([a_al, e_al, g_al]));
"Case {b,c,f}:"; IsProjEmpty(defIdealal + Ideal([b_al, c_al, f_al]));
"Case {a,c,g}:"; IsProjEmpty(defIdealal + Ideal([a_al, c_al, g_al]));
"Case {b,d,h}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, h_al]));

// Case {b,d,i} (two adjacent edges + far corner, D4-orbit size 4)
ideal := defIdealal + Ideal([b_al, d_al, i_al]);
"Case {b,d,i}. Empty?"; IsProjEmpty(ideal);
GIMS_bdi, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit hits then ideals mod symmetry of minimal prime components:";
OC;
GIMS_bdi;
// 4 triples x 32 points = 128 points.

// Case {b,e,h} (middle column, D4-orbit size 2)
ideal := defIdealal + Ideal([b_al, e_al, h_al]);
"Case {b,e,h}. Empty?"; IsProjEmpty(ideal);
GIMS_beh, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit hits then ideals mod symmetry of minimal prime components:";
OC;
GIMS_beh;
// 2 triples x 32 points = 64 points.

// Case {a,e,i} (diagonal, D4-orbit size 2)
ideal := defIdealal + Ideal([a_al, e_al, i_al]);
"Case {a,e,i}. Empty?"; IsProjEmpty(ideal);
GIMS_aei, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit hits then ideals mod symmetry of minimal prime components:";
OC;
GIMS_aei;
// 2 triples x 32 points = 64 points.  Total: 128 + 64 + 64 = 256.

// ------------------------------------------------------------------
"---------------- Singular points of X, and comparison -------------------------";
Xal      := Scheme(ProjectiveSpace(Sal), defIdealal);
IXalSing := DefiningIdeal(SingularSubscheme(Xal));
Pallist  := RadicalDecomposition(IXalSing);
GIMSsing, OCsing := ReduceByGInQQal(Pallist);
"Number of singular points:"; #Pallist;
"Orbit count then ideals mod symmetry for Sing(X):";
OCsing;
GIMSsing;

// V(P) inside V(IXalSing) iff IXalSing subset P (P prime). Sing(X) is G-invariant, so one P per orbit is enough.
"Is each 3-zero point singular? ({b,d,i}, {b,e,h}, {a,e,i}):";
IXalSing subset GIMS_bdi[1];Radical(IXalSing) subset Radical(GIMS_bdi[1]);
IXalSing subset GIMS_beh[1];Radical(IXalSing) subset Radical(GIMS_beh[1]);
IXalSing subset GIMS_aei[1];Radical(IXalSing) subset Radical(GIMS_aei[1]);
// Both have 256 points, so X_{>=3} = Sing(X).