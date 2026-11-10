// load "chapterII/IdealOfLines_al.m";

"IDEAL OF LINES NOW FOR QQal: --------------------------------------";
load "SetupX_QQal.m";

// I think setting up the rings separately is the best way to get MonomialCoefficient to work
MoreVariables<a1,a2,a3,a4,a5,a6,a7,a8,a0,d1,d2,d3,d4,d5,d6,d7,d8,d0> := PolynomialRing(QQal,18);
ParamRing<lam,mu> := PolynomialRing(MoreVariables,2);

ev := hom< S -> ParamRing | mu*a1+lam*d1,mu*a2+lam*d2,mu*a3+lam*d3,mu*a4+lam*d4,mu*a5+lam*d5,mu*a6+lam*d6,mu*a7+lam*d7,mu*a8+lam*d8,mu*a0+lam*d0>; // may not need square brackets? anyway. ill remove them. caleb if it breaks then ad dback.

// substitute lines and extract coefficients to form new ideal (fano 1 (X))
lineEqtnList := [];
for ftil_al in [f1_al, f2_al, f3_al, f4_al, f5_al, f6_al] do
    evf := ev(ftil_al); // substituted polynomial
    ftil_al;
    evf;
    Append(~lineEqtnList, MonomialCoefficient(evf, lam^2));
    Append(~lineEqtnList, MonomialCoefficient(evf, mu^2));
    Append(~lineEqtnList, MonomialCoefficient(evf, lam*mu));
    end for;

"Ideal of possible lines has dimension:";
lineIdeal := ideal<MoreVariables|lineEqtnList>;
Dimension(lineIdeal);
// 4 [ 7, 16, 17, 18 ]
// ok, cone in affine space has dimension 4, 
// so in projective space we have 3 dimensions worth of lines

"Primary decomposition:";
// PrimaryDecomposition(lineIdeal);
"moot";

"Radical decomposition:";
RadicalDecomposition(lineIdeal);

"IdealOfLines_al loaded."