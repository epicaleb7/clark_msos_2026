//% load "Step2/C2_Singularities/1a_ComputeSingularitiesSchemeWay.m";
// Sing(X) over QQ via Magma's SingularSubscheme. Defines X, XSing, IXSing, Plist (its RadicalDecomposition).

load "SetupX.m";

X := Scheme(ProjectiveSpace(S),defIdeal);
XSing := SingularSubscheme(X);
IXSing := DefiningIdeal(XSing);
Plist := RadicalDecomposition(IXSing);
"1 (compute XSing) loaded.";