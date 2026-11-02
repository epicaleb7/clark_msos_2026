// load "Week6/LemmaB.m";
// Lemma B check: Jacobian minors at a point P on exactly one line x_i = 0.
// Variables x1..x9, plus P1..P9 as symbols for the coordinates of P.
R<x1,x2,x3,x4,x5,x6,x7,x8,x9,P1,P2,P3,P4,P5,P6,P7,P8,P9> := PolynomialRing(Rationals(), 18);

// The six quadrics (f_1,...,f_6 from the thesis)
f1 := x7^2 + x8^2 + x9^2 - (x1^2 + x4^2 + x7^2);
f2 := x1^2 + x4^2 + x7^2 - (x2^2 + x5^2 + x8^2);
f3 := x2^2 + x5^2 + x8^2 - (x3^2 + x6^2 + x9^2);
f4 := x3^2 + x6^2 + x9^2 - (x1^2 + x5^2 + x9^2);
f5 := x1^2 + x5^2 + x9^2 - (x3^2 + x5^2 + x7^2);
f6 := x3^2 + x5^2 + x7^2 - (x1^2 + x2^2 + x3^2);
fs := [f1, f2, f3, f4, f5, f6];

// Jacobian: 6 rows (quadrics), 9 columns (x1..x9)
J := Matrix([[Derivative(f, j) : j in [1..9]] : f in fs]);

// Minor at P, in the chart x_k = 1, with P_i = 0,
// deleting the columns i, m (and k, which isn't a variable in the chart).
function MinorAt(R, J, i, m, k)
    // substitute x_j -> P_j for every j
    vals := [R.j : j in [10..18]] cat [R.j : j in [10..18]];
    // dehomogenise: x_k = P_k = 1
    vals[k] := R!1;  vals[9+k] := R!1;
    // P is on the line x_i = 0
    vals[i] := R!0;  vals[9+i] := R!0;
    JP := Matrix([[Evaluate(J[r][c], vals) : c in [1..9]] : r in [1..6]]);
    cols := [c : c in [1..9] | c notin {i, m, k}];
    M := Matrix([[JP[r][c] : c in cols] : r in [1..6]]);
    return Determinant(M);
end function;

// Case 1: i ne 5. Chart D(x5), so k = 5. m = 3 if i in {1,9}, else m = 1.
print "i = 1, m = 3:", MinorAt(R, J, 1, 3, 5);
print "i = 2, m = 1:", MinorAt(R, J, 2, 1, 5);
print "i = 3, m = 1:", MinorAt(R, J, 3, 1, 5);
print "i = 4, m = 1:", MinorAt(R, J, 4, 1, 5);
print "i = 6, m = 1:", MinorAt(R, J, 6, 1, 5);
print "i = 7, m = 1:", MinorAt(R, J, 7, 1, 5);
print "i = 8, m = 1:", MinorAt(R, J, 8, 1, 5);
print "i = 9, m = 3:", MinorAt(R, J, 9, 3, 5);

// Case 5: i = 5. Chart D(x1), so k = 1, and m = 3.
print "i = 5, m = 3 (chart x1):", MinorAt(R, J, 5, 3, 1);

// Sanity check: the opposite entry m = 10 - i should give 0.
print "i = 1, m = 9 (should be 0):", MinorAt(R, J, 1, 9, 5);