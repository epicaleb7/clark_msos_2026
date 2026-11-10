//% load "chapterII/IdealOfLines.m";



// --------- For QQ ---------
load "SetupX.m";

// I think setting up the rings separately is the best way to get MonomialCoefficient to work
MoreVariables<a1,a2,a3,a4,a5,a6,a7,a8,a9,d1,d2,d3,d4,d5,d6,d7,d8,d9> := PolynomialRing(QQ,18);
ParamRing<lam,mu> := PolynomialRing(MoreVariables,2);

ev := hom< S -> ParamRing | mu*a1+lam*d1,mu*a2+lam*d2,mu*a3+lam*d3,mu*a4+lam*d4,mu*a5+lam*d5,mu*a6+lam*d6,mu*a7+lam*d7,mu*a8+lam*d8,mu*a9+lam*d9>; // may not need square brackets? anyway. ill remove them. caleb if it breaks then ad dback.

// substitute lines and extract coefficients to form new ideal (fano 1 (X))
lineEqtnList := [];
for ftil in [f1, f2, f3, f4, f5, f6] do
    evf := ev(ftil); // substituted polynomial
    // ftil;
    // evf;
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

// "Primary decomposition:";
// PrimaryDecomposition(lineIdeal);

"Radical:";
time radLineIdeal := Radical(lineIdeal);
radLineIdeal;

// Emptiness over QQbar can be tested over QQ: the radical doesn't change under field extension.
IsProjEmpty := function(J)
    RadJ := Radical(J);
    return RadJ eq ideal<MoreVariables|1> or RadJ eq ideal<MoreVariables|[a1,a2,a3,a4,a5,a6,a7,a8,a9,d1,d2,d3,d4,d5,d6,d7,d8,d9]>;
end function;
IsProjEmpty(radLineIdeal); // returns false
// hey claude. how can this return false? if it also returns all a_i d_j = a_j d_i? which means projectively a = d

"Radical decomposition:";
RadicalDecomposition(lineIdeal);

"IdealOfLines loaded.";