// load "chapterIII/C1_Degeneracies/QQ zeta8/C1_FourZeros.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "chapterIII/C1_Degeneracies/QQ zeta8/ReduceByAInQQal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with four zero coordinates -------------------------";
// Up to D4 there are 23 cases (D4-orbit sizes add up to 126 = C(9,4)). All should be empty (true).
"Case {d,e,f,i}:"; IsProjEmpty(defIdealal + Ideal([d_al, e_al, f_al, i_al]));
"Case {d,e,g,i}:"; IsProjEmpty(defIdealal + Ideal([d_al, e_al, g_al, i_al]));
"Case {a,b,c,f}:"; IsProjEmpty(defIdealal + Ideal([a_al, b_al, c_al, f_al]));
"Case {e,f,h,i}:"; IsProjEmpty(defIdealal + Ideal([e_al, f_al, h_al, i_al]));
"Case {c,e,g,h}:"; IsProjEmpty(defIdealal + Ideal([c_al, e_al, g_al, h_al]));
"Case {b,d,e,h}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, e_al, h_al]));
"Case {d,f,g,h}:"; IsProjEmpty(defIdealal + Ideal([d_al, f_al, g_al, h_al]));
"Case {b,e,g,i}:"; IsProjEmpty(defIdealal + Ideal([b_al, e_al, g_al, i_al]));
"Case {b,c,d,e}:"; IsProjEmpty(defIdealal + Ideal([b_al, c_al, d_al, e_al]));
"Case {b,d,g,i}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, g_al, i_al]));
"Case {a,b,h,i}:"; IsProjEmpty(defIdealal + Ideal([a_al, b_al, h_al, i_al]));
"Case {a,d,f,h}:"; IsProjEmpty(defIdealal + Ideal([a_al, d_al, f_al, h_al]));
"Case {a,c,g,h}:"; IsProjEmpty(defIdealal + Ideal([a_al, c_al, g_al, h_al]));
"Case {a,d,f,g}:"; IsProjEmpty(defIdealal + Ideal([a_al, d_al, f_al, g_al]));
"Case {a,b,c,i}:"; IsProjEmpty(defIdealal + Ideal([a_al, b_al, c_al, i_al]));
"Case {b,d,e,i}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, e_al, i_al]));
"Case {c,e,g,i}:"; IsProjEmpty(defIdealal + Ideal([c_al, e_al, g_al, i_al]));
"Case {a,b,g,h}:"; IsProjEmpty(defIdealal + Ideal([a_al, b_al, g_al, h_al]));
"Case {a,c,g,i}:"; IsProjEmpty(defIdealal + Ideal([a_al, c_al, g_al, i_al]));
"Case {b,c,d,g}:"; IsProjEmpty(defIdealal + Ideal([b_al, c_al, d_al, g_al]));
"Case {b,d,f,h}:"; IsProjEmpty(defIdealal + Ideal([b_al, d_al, f_al, h_al]));
"Case {c,e,f,i}:"; IsProjEmpty(defIdealal + Ideal([c_al, e_al, f_al, i_al]));
"Case {b,c,f,g}:"; IsProjEmpty(defIdealal + Ideal([b_al, c_al, f_al, g_al]));
"So X has no points with four (or more) zero coordinates.";
