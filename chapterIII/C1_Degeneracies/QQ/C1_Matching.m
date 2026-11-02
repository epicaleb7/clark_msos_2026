// load "Step2/C1_Degeneracies/QQ/C1_Matching.m";

load "SetupX.m";
load "Step2/C1_Degeneracies/QQ/ReduceByG.m";

// --------------------------------------------------------------------------------------------------------------
"--------------- Degenerate points where coordinates match -------------------------";
// x^2 = y^2 means x = y or x = -y, and a sign flip swaps these, so only x = y is needed.
// Up to symmetry there are 8 cases. All components turn out to have rational coefficients.

// Case a=b (corner + adjacent edge, D4-orbit size 8)
ideal := defIdeal + Ideal(a-b);
"Case a=b. Empty?"; IsProjEmpty(ideal);
GIMS_ab, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ab;

// Case a=c (two corners on one side, D4-orbit size 4)
ideal := defIdeal + Ideal(a-c);
"Case a=c. Empty?"; IsProjEmpty(ideal);
GIMS_ac, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ac;

// Case a=e (corner + centre, D4-orbit size 4)
ideal := defIdeal + Ideal(a-e);
"Case a=e. Empty?"; IsProjEmpty(ideal);
GIMS_ae, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ae;

// Case a=f (corner + far edge, D4-orbit size 8)
ideal := defIdeal + Ideal(a-f);
"Case a=f. Empty?"; IsProjEmpty(ideal);
GIMS_af, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_af;

// Case a=i (two opposite corners, D4-orbit size 2)
ideal := defIdeal + Ideal(a-i);
"Case a=i. Empty?"; IsProjEmpty(ideal);
GIMS_ai, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_ai;

// Case b=d (two adjacent edges, D4-orbit size 4)
ideal := defIdeal + Ideal(b-d);
"Case b=d. Empty?"; IsProjEmpty(ideal);
GIMS_bd, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bd;

// Case b=e (edge + centre, D4-orbit size 4)
ideal := defIdeal + Ideal(b-e);
"Case b=e. Empty?"; IsProjEmpty(ideal);
GIMS_be, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_be;

// Case b=h (two opposite edges, D4-orbit size 2)
ideal := defIdeal + Ideal(b-h);
"Case b=h. Empty?"; IsProjEmpty(ideal);
GIMS_bh, OC := ReduceByG(RadicalDecomposition(ideal));
"Orbit count then ideals mod symmetry:";
OC;
GIMS_bh;

// --------------------------------------------------------------------------------------------------------------
// Pool the representatives of the 8 cases and reduce by G once more.
// (ReduceByG above only compared components within ONE hyperplane, never across cases,
//  and one curve can lie in several of these hyperplanes.)
"--------------- Are the 8 matching cases really 8 different orbits? -------------------------";
AllReps  := GIMS_ab cat GIMS_ac cat GIMS_ae cat GIMS_af cat GIMS_ai cat GIMS_bd cat GIMS_be cat GIMS_bh;
AllNames := ["a=b" : P in GIMS_ab] cat ["a=c" : P in GIMS_ac] cat ["a=e" : P in GIMS_ae] cat ["a=f" : P in GIMS_af]
          cat ["a=i" : P in GIMS_ai] cat ["b=d" : P in GIMS_bd] cat ["b=e" : P in GIMS_be] cat ["b=h" : P in GIMS_bh];

GIMS, OC := ReduceByG(AllReps);
"Number of different orbits among the 8 cases:";
#GIMS;
"Orbit count (how many of the 8 cases land in each orbit):";
OC;

// which cases are in which orbit?
for k in [1..#GIMS] do
    "Orbit number"; k; "contains the cases:";
    for index in [1..#AllReps] do
        if GIMS[k] in GOrbitQQ(AllReps[index]) then
            AllNames[index];
        end if;
    end for;
end for;

// How many curves are in each orbit? Here the OrbitCount trick doesn't work (a curve lies in several
// hyperplanes, so it would be counted several times). Instead: orbit-stabiliser,
// #orbit = 4096 / #{g : g(P) = P}.
"--------------- Number of curves in each orbit, and degree -------------------------";
for k in [1..#GIMS] do
    stab := #[Q : Q in GOrbitQQ(GIMS[k]) | Q eq GIMS[k]];
    "Orbit number"; k;
    "curves in the orbit:"; 4096 div stab;
    "degree:"; Degree(Curve(ProjectiveSpace(S), GIMS[k]));
end for;
