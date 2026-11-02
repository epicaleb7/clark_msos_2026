// load "Step2/C1_Degeneracies/QQ zeta24/CheckNothingSplitsOverQQalal.m";
// Counts components over QQ(zeta8, sqrt3) = CyclotomicField(24) (fast absolute version of QQal(rt3)), no orbit reduction.
load "SetupX.m";
K<z24> := CyclotomicField(24);   // = QQ(zeta8, sqrt3)
R<a,b,c,d,e,f,g,h,i> := PolynomialRing(K, 9);
I := ideal<R | [Evaluate(F,[a,b,c,d,e,f,g,h,i]) : F in Generators(defIdeal)]>;
"Matching cases, number of components over QQ(zeta8, sqrt3):";
for T in [<"a=b",a-b>, <"a=c",a-c>, <"a=e",a-e>, <"a=f",a-f>, <"a=i",a-i>, <"b=d",b-d>, <"b=e",b-e>, <"b=h",b-h>] do
    time printf "%o: %o\n", T[1], #RadicalDecomposition(I + ideal<R|T[2]>);
end for;
"Three-zero cases:";
for T in [<"{b,d,i}",[b,d,i]>, <"{b,e,h}",[b,e,h]>, <"{a,e,i}",[a,e,i]>] do
    printf "%o: %o\n", T[1], #RadicalDecomposition(I + ideal<R|T[2]>);
end for;
"Sing(X):";
time printf "%o components\n", #RadicalDecomposition(DefiningIdeal(SingularSubscheme(Scheme(ProjectiveSpace(R), I))));
quit;
