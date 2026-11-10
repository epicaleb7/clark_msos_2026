// load "chapterIII/C2_Singularities/C2_ClassifySing.m";
// CURRENT C2 script: Sing(X) over QQ(zeta8) = 256 points = 128 + 64 + 64 in 3 A-orbits, each of multiplicity 2.

load "SetupX.m";
load "SetupX_QQal.m";
// load "chapterIII/C2_Singularities/2_ReduceIXSingBySymmetries.m";

// ORGANISE THIS CODE INTO SEPARATE .M FILES LATER.

Xal := Scheme(ProjectiveSpace(Sal),defIdealal);
XalSing := SingularSubscheme(Xal);
IXalSing := DefiningIdeal(XalSing);
time Pallist := RadicalDecomposition(IXalSing);
"C2 (compute XalSing) loaded.";

"----- Now we REDUCE XalSing. -----";
load "chapterIII/lib/ReduceByAInQQal.m";
time SingIdealsModSymmetryal, OrbitCountSingal := ReduceByAInQQal(Pallist);


"----- Now we CLASSIFY the (3) points. -----";

ptList := [];
MultiplicityVec := [];
for Pal in SingIdealsModSymmetryal do;
    Y := Scheme(Ambient(Xal), Pal);
    assert #Points(Y) eq 1; // indeed they are just points.
    pt := Points(Y)[1];
    Append(~ptList, Eltseq(pt));
    #ptList;
    Append(~MultiplicityVec,Multiplicity(Xal, pt));
end for;
MultiplicityVec;

"----- Now we TELL YOU what we did. -----";
printf "Singular ideals printout: "; SingIdealsModSymmetryal;
printf "Singular points: "; ptList;
printf "Singularity orbit counts: "; OrbitCountSingal;
