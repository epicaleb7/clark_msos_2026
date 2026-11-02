// load "Step2/C1_Degeneracies/QQ zeta8/C1_TwoZeros.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta8/ReduceByGInQQal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with two zero coordinates -------------------------";
// Up to D4 there are 8 cases (D4-orbit sizes add up to 36 = C(9,2)).
// Read off the GIMS: if a THIRD coordinate is 0 in it, the points really have 3 zeros (see C1_ThreeZeros.m).
// Only {a,d} and {a,c} have exactly two zeros.
// Their primes contain e.g. g^2 - 3/2*i^2, so each prime is 2 points over QQ(zeta8, sqrt3):
// 32 primes = 64 points for each pair.

// Case {a,d} (corner + adjacent edge, D4-orbit size 8)  -- exactly two zeros
ideal := defIdealal + Ideal([a_al, d_al]);
"Case {a,d}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 8 pairs x 64 points = 512 points in X.

// Case {a,c} (two corners on one side, D4-orbit size 4)  -- exactly two zeros
ideal := defIdealal + Ideal([a_al, c_al]);
"Case {a,c}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 4 pairs x 64 points = 256 points in X.

// Case {c,d} (corner + far edge, D4-orbit size 8)  -- forces h = 0 too
ideal := defIdealal + Ideal([c_al, d_al]);
"Case {c,d}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {d,f} (two opposite edges, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdealal + Ideal([d_al, f_al]);
"Case {d,f}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {d,e} (edge + centre, D4-orbit size 4)  -- forces f = 0 too
ideal := defIdealal + Ideal([d_al, e_al]);
"Case {d,e}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {c,e} (corner + centre, D4-orbit size 4)  -- forces g = 0 too
ideal := defIdealal + Ideal([c_al, e_al]);
"Case {c,e}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {f,h} (two adjacent edges, D4-orbit size 4)  -- forces a = 0 too
ideal := defIdealal + Ideal([f_al, h_al]);
"Case {f,h}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {a,i} (two opposite corners, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdealal + Ideal([a_al, i_al]);
"Case {a,i}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
