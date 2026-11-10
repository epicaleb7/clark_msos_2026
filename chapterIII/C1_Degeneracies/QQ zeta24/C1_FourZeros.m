// load "chapterIII/C1_Degeneracies/QQ zeta24/C1_FourZeros.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "chapterIII/C1_Degeneracies/QQ zeta24/SetupX_QQalal.m";
load "chapterIII/C1_Degeneracies/QQ zeta24/ReduceByAInQQalal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with four zero coordinates -------------------------";
// Up to D4 there are 23 cases (D4-orbit sizes add up to 126 = C(9,4)). All should be empty (true).
"Case {d,e,f,i}:"; IsProjEmpty(defIdealalal + Ideal([d_alal, e_alal, f_alal, i_alal]));
"Case {d,e,g,i}:"; IsProjEmpty(defIdealalal + Ideal([d_alal, e_alal, g_alal, i_alal]));
"Case {a,b,c,f}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, b_alal, c_alal, f_alal]));
"Case {e,f,h,i}:"; IsProjEmpty(defIdealalal + Ideal([e_alal, f_alal, h_alal, i_alal]));
"Case {c,e,g,h}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, e_alal, g_alal, h_alal]));
"Case {b,d,e,h}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, e_alal, h_alal]));
"Case {d,f,g,h}:"; IsProjEmpty(defIdealalal + Ideal([d_alal, f_alal, g_alal, h_alal]));
"Case {b,e,g,i}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, e_alal, g_alal, i_alal]));
"Case {b,c,d,e}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, c_alal, d_alal, e_alal]));
"Case {b,d,g,i}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, g_alal, i_alal]));
"Case {a,b,h,i}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, b_alal, h_alal, i_alal]));
"Case {a,d,f,h}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, d_alal, f_alal, h_alal]));
"Case {a,c,g,h}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, c_alal, g_alal, h_alal]));
"Case {a,d,f,g}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, d_alal, f_alal, g_alal]));
"Case {a,b,c,i}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, b_alal, c_alal, i_alal]));
"Case {b,d,e,i}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, e_alal, i_alal]));
"Case {c,e,g,i}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, e_alal, g_alal, i_alal]));
"Case {a,b,g,h}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, b_alal, g_alal, h_alal]));
"Case {a,c,g,i}:"; IsProjEmpty(defIdealalal + Ideal([a_alal, c_alal, g_alal, i_alal]));
"Case {b,c,d,g}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, c_alal, d_alal, g_alal]));
"Case {b,d,f,h}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, d_alal, f_alal, h_alal]));
"Case {c,e,f,i}:"; IsProjEmpty(defIdealalal + Ideal([c_alal, e_alal, f_alal, i_alal]));
"Case {b,c,f,g}:"; IsProjEmpty(defIdealalal + Ideal([b_alal, c_alal, f_alal, g_alal]));
"So X has no points with four (or more) zero coordinates.";
