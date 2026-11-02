// load "SetupX_QQal.m";

// better way that currently doesnt work
// load "SetupX.m";
// QQal := AlgebraicClosure(QQ);
// Sal<a,b,c,d,e,f,g,h,i> := ChangeRing(S, QQal);
// injAl := hom<QQ -> QQal |>;
// defIdealal := ChangeRing(defIdeal, Sal, injAl); // fails.

// worse way ------------------------------------------------------------------
// QQal := AlgebraicClosure(QQ); // polyring 0 lex doesnt fix my problems with computing RadicalDecomp.
// QQal<z8> := NumberField(z8^8-1);
QQal := CyclotomicField(8); // not actually al but its suitably al
Sal<a_al,b_al,c_al,d_al,e_al,f_al,g_al,h_al,i_al>  := PolynomialRing(QQal,9);//,"lex");
q1_al := a_al^2+b_al^2+c_al^2;
q2_al := d_al^2+e_al^2+f_al^2;
q3_al := g_al^2+h_al^2+i_al^2;
q4_al := a_al^2+d_al^2+g_al^2;
q5_al := b_al^2+e_al^2+h_al^2;
q6_al := c_al^2+f_al^2+i_al^2;
q7_al := a_al^2+e_al^2+i_al^2;
q8_al := c_al^2+e_al^2+g_al^2;
f1_al := q3_al-q4_al;
f2_al := q4_al-q5_al;
f3_al := q5_al-q6_al;
f4_al := q6_al-q7_al;
f5_al := q7_al-q8_al;
f6_al := q8_al-q1_al;
f7_al := q1_al-q2_al;
f8_al := q2_al-q3_al;

"IF THINGS ARE BROKEN, ITS BECAUSE I CHANGED ftal TO BE ft_al !!! SO EVERYTHING IS UNDERSCORE EXCEPT S, QQ.";

defIdealal := ideal<Sal|f1_al,f2_al,f3_al,f4_al,f5_al,f6_al,f7_al,f8_al>;
defIdealal eq ideal<Sal|f1_al,f2_al,f3_al,f4_al,f5_al,f6_al>;
// -----------------------------------------------------------------------------


X := Scheme(ProjectiveSpace(Sal),defIdealal);