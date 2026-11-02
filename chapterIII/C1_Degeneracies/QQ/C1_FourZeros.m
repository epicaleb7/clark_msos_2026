// load "Step2/C1_Degeneracies/QQ/C1_FourZeros.m";

load "SetupX.m";
load "Step2/C1_Degeneracies/QQ/ReduceByG.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with four zero coordinates -------------------------";
// Up to D4 there are 23 cases (D4-orbit sizes add up to 126 = C(9,4)). All should be empty (true).
"Case {d,e,f,i}:"; IsProjEmpty(defIdeal + Ideal([d, e, f, i]));
"Case {d,e,g,i}:"; IsProjEmpty(defIdeal + Ideal([d, e, g, i]));
"Case {a,b,c,f}:"; IsProjEmpty(defIdeal + Ideal([a, b, c, f]));
"Case {e,f,h,i}:"; IsProjEmpty(defIdeal + Ideal([e, f, h, i]));
"Case {c,e,g,h}:"; IsProjEmpty(defIdeal + Ideal([c, e, g, h]));
"Case {b,d,e,h}:"; IsProjEmpty(defIdeal + Ideal([b, d, e, h]));
"Case {d,f,g,h}:"; IsProjEmpty(defIdeal + Ideal([d, f, g, h]));
"Case {b,e,g,i}:"; IsProjEmpty(defIdeal + Ideal([b, e, g, i]));
"Case {b,c,d,e}:"; IsProjEmpty(defIdeal + Ideal([b, c, d, e]));
"Case {b,d,g,i}:"; IsProjEmpty(defIdeal + Ideal([b, d, g, i]));
"Case {a,b,h,i}:"; IsProjEmpty(defIdeal + Ideal([a, b, h, i]));
"Case {a,d,f,h}:"; IsProjEmpty(defIdeal + Ideal([a, d, f, h]));
"Case {a,c,g,h}:"; IsProjEmpty(defIdeal + Ideal([a, c, g, h]));
"Case {a,d,f,g}:"; IsProjEmpty(defIdeal + Ideal([a, d, f, g]));
"Case {a,b,c,i}:"; IsProjEmpty(defIdeal + Ideal([a, b, c, i]));
"Case {b,d,e,i}:"; IsProjEmpty(defIdeal + Ideal([b, d, e, i]));
"Case {c,e,g,i}:"; IsProjEmpty(defIdeal + Ideal([c, e, g, i]));
"Case {a,b,g,h}:"; IsProjEmpty(defIdeal + Ideal([a, b, g, h]));
"Case {a,c,g,i}:"; IsProjEmpty(defIdeal + Ideal([a, c, g, i]));
"Case {b,c,d,g}:"; IsProjEmpty(defIdeal + Ideal([b, c, d, g]));
"Case {b,d,f,h}:"; IsProjEmpty(defIdeal + Ideal([b, d, f, h]));
"Case {c,e,f,i}:"; IsProjEmpty(defIdeal + Ideal([c, e, f, i]));
"Case {b,c,f,g}:"; IsProjEmpty(defIdeal + Ideal([b, c, f, g]));
"So X has no points with four (or more) zero coordinates.";
