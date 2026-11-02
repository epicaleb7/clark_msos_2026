// load "Step2/C1_Degeneracies/QQ/C1_TwoZeros.m";

load "SetupX.m";
load "Step2/C1_Degeneracies/QQ/ReduceByG.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with two zero coordinates -------------------------";
// Up to D4 there are 8 cases (D4-orbit sizes add up to 36 = C(9,2)).
// Read off the GIMS: if a THIRD coordinate is 0 in it, the points really have 3 zeros (see C1_ThreeZeros.m).
// Only {a,d} and {a,c} have exactly two zeros.
// Over QQ each prime is a Galois orbit of 8 points (all defined over QQ(sqrt2, sqrt3, i)):
// 8 primes = 64 points for each pair.

// Case {a,d} (corner + adjacent edge, D4-orbit size 8)  -- exactly two zeros
ideal := defIdeal + Ideal([a, d]);
"Case {a,d}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 8 pairs x 64 points = 512 points in X.

// Case {a,c} (two corners on one side, D4-orbit size 4)  -- exactly two zeros
ideal := defIdeal + Ideal([a, c]);
"Case {a,c}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
// 4 pairs x 64 points = 256 points in X.

// Case {c,d} (corner + far edge, D4-orbit size 8)  -- forces h = 0 too
ideal := defIdeal + Ideal([c, d]);
"Case {c,d}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {d,f} (two opposite edges, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdeal + Ideal([d, f]);
"Case {d,f}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {d,e} (edge + centre, D4-orbit size 4)  -- forces f = 0 too
ideal := defIdeal + Ideal([d, e]);
"Case {d,e}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {c,e} (corner + centre, D4-orbit size 4)  -- forces g = 0 too
ideal := defIdeal + Ideal([c, e]);
"Case {c,e}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {f,h} (two adjacent edges, D4-orbit size 4)  -- forces a = 0 too
ideal := defIdeal + Ideal([f, h]);
"Case {f,h}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;

// Case {a,i} (two opposite corners, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdeal + Ideal([a, i]);
"Case {a,i}. Empty?"; IsProjEmpty(ideal);
GIMS, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS;
