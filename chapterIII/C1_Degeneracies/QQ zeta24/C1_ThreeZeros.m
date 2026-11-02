// load "Step2/C1_Degeneracies/QQ zeta24/C1_ThreeZeros.m";
// NOT RUN over QQalal (30 Oct): too slow over QQal(rt3), and sqrt3 is not needed here -- every component is
// already defined over QQal, so the output is the same as ../by_cases_caleb_style/C1_ThreeZeros_output.txt.

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta24/SetupX_QQalal.m";
load "Step2/C1_Degeneracies/QQ zeta24/ReduceByGInQQalal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with three zero coordinates -------------------------";
// Up to D4 there are 16 cases (D4-orbit sizes add up to 84 = C(9,3)). 13 are empty.
// Each prime in the nonempty cases is a single point (linear equations).

"Empty cases (should all be true):";
"Case {c,d,i}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, d_alal, i_alal]));
"Case {a,b,c}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, b_alal, c_alal]));
"Case {a,c,f}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, c_alal, f_alal]));
"Case {c,g,h}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, g_alal, h_alal]));
"Case {b,d,e}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, e_alal]));
"Case {d,e,g}:"; IsProjEmpty(defIdealalal + Ideal([d_alal, e_alal, g_alal]));
"Case {b,e,i}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, e_alal, i_alal]));
"Case {c,d,f}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, d_alal, f_alal]));
"Case {b,f,i}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, f_alal, i_alal]));
"Case {a,e,g}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, e_alal, g_alal]));
"Case {b,c,f}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, c_alal, f_alal]));
"Case {a,c,g}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, c_alal, g_alal]));
"Case {b,d,h}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, h_alal]));

// Case {b,d,i} (two adjacent edges + far corner, D4-orbit size 4)
ideal := defIdealalal + Ideal([b_alal, d_alal, i_alal]);
"Case {b,d,i}. Empty?"; IsProjEmpty(ideal);
GIMS_bdi, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bdi;
// 4 triples x 32 points = 128 points.

// Case {b,e,h} (middle column, D4-orbit size 2)
ideal := defIdealalal + Ideal([b_alal, e_alal, h_alal]);
"Case {b,e,h}. Empty?"; IsProjEmpty(ideal);
GIMS_beh, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_beh;
// 2 triples x 32 points = 64 points.

// Case {a,e,i} (diagonal, D4-orbit size 2)
ideal := defIdealalal + Ideal([a_alal, e_alal, i_alal]);
"Case {a,e,i}. Empty?"; IsProjEmpty(ideal);
GIMS_aei, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_aei;
// 2 triples x 32 points = 64 points.  Total: 128 + 64 + 64 = 256.

// ------------------------------------------------------------------
"---------------- Singular points of X, and comparison -------------------------";
Xalal      := Scheme(ProjectiveSpace(Salal), defIdealalal);
IXalalSing := DefiningIdeal(SingularSubscheme(Xalal));
Palallist  := RadicalDecomposition(IXalalSing);
GIMSsing, OCsing := ReduceByGInQQalal(Palallist);
"Number of singular points:"; #Palallist;
"Orbit count then ideals mod symmetry for Sing(X):";
OCsing;
GIMSsing;

// V(P) inside V(IXalalSing) iff IXalalSing subset P (P prime). Sing(X) is G-invariant, so one P per orbit is enough.
"Is each 3-zero point singular? ({b,d,i}, {b,e,h}, {a,e,i}):";
IXalalSing subset GIMS_bdi[1];
IXalalSing subset GIMS_beh[1];
IXalalSing subset GIMS_aei[1];
// Both have 256 points, so X_{>=3} = Sing(X).
