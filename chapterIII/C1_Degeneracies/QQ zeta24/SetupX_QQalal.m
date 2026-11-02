// load "Step2/C1_Degeneracies/QQ zeta24/SetupX_QQalal.m";   (after SetupX.m and SetupX_QQal.m)
// QQalal = QQal(rt3) = QQ(zeta8, sqrt3): QQal with sqrt3 adjoined. Needed for the two-zero points
// (e.g. g^2 = 3/2 i^2). In the output: zeta_8^2 = i, zeta_8 - zeta_8^3 = sqrt2, rt3 = sqrt3.
Pxx<xx> := PolynomialRing(QQal);
QQalal<rt3> := ext<QQal | xx^2 - 3>;
Salal<a_alal,b_alal,c_alal,d_alal,e_alal,f_alal,g_alal,h_alal,i_alal> := PolynomialRing(QQalal, 9);
q1_alal := a_alal^2+b_alal^2+c_alal^2;
q2_alal := d_alal^2+e_alal^2+f_alal^2;
q3_alal := g_alal^2+h_alal^2+i_alal^2;
q4_alal := a_alal^2+d_alal^2+g_alal^2;
q5_alal := b_alal^2+e_alal^2+h_alal^2;
q6_alal := c_alal^2+f_alal^2+i_alal^2;
q7_alal := a_alal^2+e_alal^2+i_alal^2;
q8_alal := c_alal^2+e_alal^2+g_alal^2;
defIdealalal := ideal<Salal | q3_alal-q4_alal, q4_alal-q5_alal, q5_alal-q6_alal, q6_alal-q7_alal, q7_alal-q8_alal, q8_alal-q1_alal>;
"SetupX_QQalal loaded (QQalal<rt3>, Salal, defIdealalal).";
