// load "chapterII/XChecks.m";

load "SetupX_QQal.m";

// defIdealal := ideal<Sal|f1_al,f2_al,f3_al,f4_al,f5_al,f6_al,f7_al,f8_al>;
IsPrime(defIdealal);
// IsAbsolutelyIrreducible(X);

load "SetupX.m";
seed := 7;
"Seed is ", seed;
SetSeed(seed);
R := PolynomialRing(Rationals(), 8);
c := [Random(-10,10) : i in [1..8]];
sub := [R.i : i in [1..8]] cat [&+[c[i]*R.i : i in [1..8]]];   // x9 := random linear form
eqs := [Evaluate(f, sub) : f in Basis(defIdeal)];
C := Curve(ProjectiveSpace(R), eqs);
assert 1 eq Dimension(C);                 // sanity check: want 1
SetVerbose("Groebner", 1);

assert IsReduced(Scheme(ProjectiveSpace(R), eqs));   // want true
"REDUCIBILITY NOW CHECKED";

time IsAbsolutelyIrreducible(C);