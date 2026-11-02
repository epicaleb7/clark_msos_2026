// load "Step2/C1_Degeneracies/QQ/C1_ThreeZeros.m";

load "SetupX.m";
load "Step2/C1_Degeneracies/QQ/ReduceByG.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with three zero coordinates -------------------------";
// Up to D4 there are 16 cases (D4-orbit sizes add up to 84 = C(9,3)). 13 are empty.
// Over QQ each prime in the nonempty cases is a Galois orbit of points (2 or 4 points), not a single point.

"Empty cases (should all be true):";
"Case {c,d,i}:"; IsProjEmpty(defIdeal + Ideal([c, d, i]));
"Case {a,b,c}:"; IsProjEmpty(defIdeal + Ideal([a, b, c]));
"Case {a,c,f}:"; IsProjEmpty(defIdeal + Ideal([a, c, f]));
"Case {c,g,h}:"; IsProjEmpty(defIdeal + Ideal([c, g, h]));
"Case {b,d,e}:"; IsProjEmpty(defIdeal + Ideal([b, d, e]));
"Case {d,e,g}:"; IsProjEmpty(defIdeal + Ideal([d, e, g]));
"Case {b,e,i}:"; IsProjEmpty(defIdeal + Ideal([b, e, i]));
"Case {c,d,f}:"; IsProjEmpty(defIdeal + Ideal([c, d, f]));
"Case {b,f,i}:"; IsProjEmpty(defIdeal + Ideal([b, f, i]));
"Case {a,e,g}:"; IsProjEmpty(defIdeal + Ideal([a, e, g]));
"Case {b,c,f}:"; IsProjEmpty(defIdeal + Ideal([b, c, f]));
"Case {a,c,g}:"; IsProjEmpty(defIdeal + Ideal([a, c, g]));
"Case {b,d,h}:"; IsProjEmpty(defIdeal + Ideal([b, d, h]));

// Case {b,d,i} (two adjacent edges + far corner, D4-orbit size 4)
ideal := defIdeal + Ideal([b, d, i]);
"Case {b,d,i}. Empty?"; IsProjEmpty(ideal);
GIMS_bdi, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bdi;
// 16 primes, each 2 points over QQ(sqrt2): 32 points per triple, 4 triples x 32 = 128 points.

// Case {b,e,h} (middle column, D4-orbit size 2)
ideal := defIdeal + Ideal([b, e, h]);
"Case {b,e,h}. Empty?"; IsProjEmpty(ideal);
GIMS_beh, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_beh;
// 8 primes, each 4 points over QQ(sqrt2, i): 32 points per triple, 2 triples x 32 = 64 points.

// Case {a,e,i} (diagonal, D4-orbit size 2)
ideal := defIdeal + Ideal([a, e, i]);
"Case {a,e,i}. Empty?"; IsProjEmpty(ideal);
GIMS_aei, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_aei;
// 16 primes, each 2 points over QQ(i): 2 triples x 32 = 64 points.  Total: 128 + 64 + 64 = 256 points over QQbar.

// ------------------------------------------------------------------
"---------------- Singular points of X, and comparison -------------------------";
XQ      := Scheme(ProjectiveSpace(S), defIdeal);
IXSing := DefiningIdeal(SingularSubscheme(XQ));
Plist  := RadicalDecomposition(IXSing);
GIMSsing, OCsing := ReduceByG(Plist);
"Number of components of Sing(X) over QQ (Galois orbits of points):"; #Plist;
"Orbit count then ideals mod symmetry for Sing(X):";
OCsing;
GIMSsing;

// V(P) inside V(IXSing) iff IXSing subset P (P prime). Sing(X) is G-invariant, so one P per orbit is enough.
"Is each 3-zero point singular? ({b,d,i}, {b,e,h}, {a,e,i}):";
IXSing subset GIMS_bdi[1];
IXSing subset GIMS_beh[1];
IXSing subset GIMS_aei[1];
// Over QQ: Sing(X) has 112 primes = 2*8 ({b,e,h}) + 2*16 ({a,e,i}) + 4*16 ({b,d,i}), OC [16, 32, 64],
// the same primes as the three 3-zero cases. Over QQbar both are the same 256 points, so X_{>=3} = Sing(X).
