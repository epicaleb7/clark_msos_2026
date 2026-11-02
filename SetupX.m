// load "SetupX.m";
// Setup of I(X)
QQ := Rationals();
S<a,b,c,d,e,f,g,h,i> := PolynomialRing(QQ,9);
q1 := a^2+b^2+c^2;
q2 := d^2+e^2+f^2;
q3 := g^2+h^2+i^2;
q4 := a^2+d^2+g^2;
q5 := b^2+e^2+h^2;
q6 := c^2+f^2+i^2;
q7 := a^2+e^2+i^2;
q8 := c^2+e^2+g^2;
f1 := q3-q4;
f2 := q4-q5;
f3 := q5-q6;
f4 := q6-q7;
f5 := q7-q8;
f6 := q8-q1;
f7 := q2-q1;
f8 := q3-q2;

defIdeal := ideal<S|f1,f2,f3,f4,f5,f6>;
// defIdeal suffices to give ft3..ft8: (yes I tried 1..6; didn't work.)
defIdeal eq ideal<S|f1,f2,f3,f4,f5,f6,f7,f8>;
"SetupX loaded.";