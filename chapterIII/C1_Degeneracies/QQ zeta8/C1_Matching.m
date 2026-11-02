// load "Step2/C1_Degeneracies/QQ zeta8/C1_Matching.m";

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta8/ReduceByGInQQal.m";

// --------------------------------------------------------------------------------------------------------------
"--------------- Degenerate points where coordinates match -------------------------";
// x^2 = y^2 means x = y or x = -y, and a sign flip swaps these, so only x = y is needed.
// Up to symmetry there are 8 cases. All components turn out to have rational coefficients.

// Case a=b (corner + adjacent edge, D4-orbit size 8)
ideal := defIdealal + Ideal(a_al-b_al);
"Case a=b. Empty?"; IsProjEmpty(ideal);
GIMS_ab, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ab;

// Case a=c (two corners on one side, D4-orbit size 4)
ideal := defIdealal + Ideal(a_al-c_al);
"Case a=c. Empty?"; IsProjEmpty(ideal);
GIMS_ac, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ac;

// Case a=e (corner + centre, D4-orbit size 4)
ideal := defIdealal + Ideal(a_al-e_al);
"Case a=e. Empty?"; IsProjEmpty(ideal);
GIMS_ae, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ae;

// Case a=f (corner + far edge, D4-orbit size 8)
ideal := defIdealal + Ideal(a_al-f_al);
"Case a=f. Empty?"; IsProjEmpty(ideal);
GIMS_af, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_af;

// Case a=i (two opposite corners, D4-orbit size 2)
ideal := defIdealal + Ideal(a_al-i_al);
"Case a=i. Empty?"; IsProjEmpty(ideal);
GIMS_ai, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ai;

// Case b=d (two adjacent edges, D4-orbit size 4)
ideal := defIdealal + Ideal(b_al-d_al);
"Case b=d. Empty?"; IsProjEmpty(ideal);
GIMS_bd, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bd;

// Case b=e (edge + centre, D4-orbit size 4)
ideal := defIdealal + Ideal(b_al-e_al);
"Case b=e. Empty?"; IsProjEmpty(ideal);
GIMS_be, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_be;

// Case b=h (two opposite edges, D4-orbit size 2)
ideal := defIdealal + Ideal(b_al-h_al);
"Case b=h. Empty?"; IsProjEmpty(ideal);
GIMS_bh, OC := ReduceByGInQQal(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bh;

// --------------------------------------------------------------------------------------------------------------
// Pool the representatives of the 8 cases and reduce by G once more.
// (ReduceByGInQQal above only compared components within ONE hyperplane, never across cases,
//  and one curve can lie in several of these hyperplanes.)
"--------------- Are the 8 matching cases really 8 different orbits? -------------------------";
AllReps  := GIMS_ab cat GIMS_ac cat GIMS_ae cat GIMS_af cat GIMS_ai cat GIMS_bd cat GIMS_be cat GIMS_bh;
AllNames := ["a=b" : P in GIMS_ab] cat ["a=c" : P in GIMS_ac] cat ["a=e" : P in GIMS_ae] cat ["a=f" : P in GIMS_af]
          cat ["a=i" : P in GIMS_ai] cat ["b=d" : P in GIMS_bd] cat ["b=e" : P in GIMS_be] cat ["b=h" : P in GIMS_bh];

GIMS, OC := ReduceByGInQQal(AllReps);
"Number of different orbits among the 8 cases:";
#GIMS;
"Orbit count (how many of the 8 cases land in each orbit):";
OC;

// which cases are in which orbit?
for k in [1..#GIMS] do
    "Orbit number"; k; "contains the cases:";
    for index in [1..#AllReps] do
        if GIMS[k] in GOrbitQQal(AllReps[index]) then
            AllNames[index];
        end if;
    end for;
end for;

// How many curves are in each orbit? Here the OrbitCount trick doesn't work (a curve lies in several
// hyperplanes, so it would be counted several times). Instead: orbit-stabiliser,
// #orbit = 2048 / #{g : g(P) = P}.
"--------------- Number of curves in each orbit, and degree -------------------------";
for k in [1..#GIMS] do
    stab := #[Q : Q in GOrbitQQal(GIMS[k]) | Q eq GIMS[k]];
    "Orbit number"; k;
    "curves in the orbit:"; 2048 div stab;
    "degree:"; Degree(Curve(ProjectiveSpace(Sal), GIMS[k]));
end for;
