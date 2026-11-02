// load "Step2/C1_Degeneracies/QQ zeta24/C1_TwoZeros.m";
// This code actually has some Calebian modifications and should not be entirely ignored if I ever cleanup/post this.

load "SetupX.m";
load "SetupX_QQal.m";
load "Step2/C1_Degeneracies/QQ zeta24/SetupX_QQalal.m";
load "Step2/C1_Degeneracies/QQ zeta24/ReduceByGInQQalal.m";

// ------------------------------------------------------------------
"---------------- Degenerate points with two zero coordinates -------------------------";
// Up to D4 there are 8 cases (D4-orbit sizes add up to 36 = C(9,2)).
// Read off the GIMS: if a THIRD coordinate is 0 in it, the points really have 3 zeros (see C1_ThreeZeros.m).
// Only {a,d} and {a,c} have exactly two zeros.
// Over QQalal every prime is a single point (over QQal they were pairs, from g^2 - 3/2*i^2):
// 64 primes = 64 points for each pair.

// Case {a,d} (corner + adjacent edge, D4-orbit size 8)  -- exactly two zeros
ideal := defIdealalal + Ideal([a_alal, d_alal]);
"Case {a,d}. Empty?"; IsProjEmpty(ideal);
time GIMS1, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS1;
// 8 pairs x 64 points = 512 points in X.

// Case {a,c} (two corners on one side, D4-orbit size 4)  -- exactly two zeros
ideal := defIdealalal + Ideal([a_alal, c_alal]);
"Case {a,c}. Empty?"; IsProjEmpty(ideal);
time GIMS2, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS2;
// 4 pairs x 64 points = 256 points in X.

// Case {c,d} (corner + far edge, D4-orbit size 8)  -- forces h = 0 too
ideal := defIdealalal + Ideal([c_alal, d_alal]);
"Case {c,d}. Empty?"; IsProjEmpty(ideal);
time GIMS3, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS3;

// Case {d,f} (two opposite edges, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdealalal + Ideal([d_alal, f_alal]);
"Case {d,f}. Empty?"; IsProjEmpty(ideal);
time GIMS4, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS4;

// Case {d,e} (edge + centre, D4-orbit size 4)  -- forces f = 0 too
ideal := defIdealalal + Ideal([d_alal, e_alal]);
"Case {d,e}. Empty?"; IsProjEmpty(ideal);
time GIMS5, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS5;

// Case {c,e} (corner + centre, D4-orbit size 4)  -- forces g = 0 too
ideal := defIdealalal + Ideal([c_alal, e_alal]);
"Case {c,e}. Empty?"; IsProjEmpty(ideal);
time GIMS6, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS6;

// Case {f,h} (two adjacent edges, D4-orbit size 4)  -- forces a = 0 too
ideal := defIdealalal + Ideal([f_alal, h_alal]);
"Case {f,h}. Empty?"; IsProjEmpty(ideal);
time GIMS7, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS7;

// Case {a,i} (two opposite corners, D4-orbit size 2)  -- forces e = 0 too
ideal := defIdealalal + Ideal([a_alal, i_alal]);
"Case {a,i}. Empty?"; IsProjEmpty(ideal);
time GIMS8, OC := ReduceByGInQQalal(RadicalDecomposition(ideal));
"orbit hits then ideals mod symmetry:";
OC;
GIMS8;


// -- modify the function to keep indices
ReduceByGInQQalal2 := function(Plist)
    error if #Plist gt 0 and Generic(Plist[1]) cmpne Salal,
        "ReduceByGInQQalal expects ideals of Salal (over QQalal).";
    GenericIdealsModSymmetry := [];
    OrbitCount := [1: i in [0..hardcodedsizeoforbitcountieexpectedamximumsizeofGIMS]]; // otherwise the code is more complex lol
    j := 0;
    for P in Plist do
    j +:= 1;
        // compute some symmetry transformations of my ideal
        SymmetriesOfP := GOrbitQQalal(P);
        // if one element of SymmetriesOfP in GenericIdealsModSymmetry
        if exists(IndexInGIMSOfsymmetricP){
            Index(GenericIdealsModSymmetry,symmetricP) :
            symmetricP in SymmetriesOfP |
            symmetricP in GenericIdealsModSymmetry
            } then
            OrbitCount[IndexInGIMSOfsymmetricP] +:= 1;
            j,"already exists, of type",IndexInGIMSOfsymmetricP;
        else // it's a new ideal!
            Append(~GenericIdealsModSymmetry, P);
            j,"is new!"
        end if;
    end for;
    return GenericIdealsModSymmetry, OrbitCount[1..#GenericIdealsModSymmetry];
end function;

// ----- Pool and reduce -----
GIMSlist := [GIMS1,GIMS2,GIMS3,GIMS4,GIMS5,GIMS6,GIMS7,GIMS8];
GIMSPooled, OC := ReduceByQInQQalal2(GIMSlist);