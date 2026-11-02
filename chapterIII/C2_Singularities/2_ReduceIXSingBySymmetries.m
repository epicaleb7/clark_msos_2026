// load "Step2/C2_Singularities/2_ReduceIXSingBySymmetries.m";
// Older script-style version of Step2/lib/ReduceByG.m, hard-wired to Plist from 1a (OrbitCount hard-coded to length 8).
load "Step2/C2_Singularities/1a_ComputeSingularitiesSchemeWay.m";

// First write down all symmetries of the quadrics
// we define a ring homomorphism for (the action of) each symmetry, as described in X Step 2 B.
// this requires a list with 2^9 * 8 elements.

rho := hom<S -> S | [c,f,i,b,e,h,a,d,g]>; // rotate cw
sigma := hom<S -> S | [g,h,i,d,e,f,a,b,c]>; // flip about x-axis
tauVec := [hom<S -> S | [j eq i select -S.j else S.j : j in [1..9]]> : i in [1..9]];

// action of G on an ideal:
function ActOnIdeal(phi, J)
    gens := Generators(J);
    new_gens := [S ! phi(f) : f in gens ];
    return Ideal(new_gens);
end function;

SymmetryList := function(P)
    SymmetriesOfPList := [];
    for rhoPower in [0..3] do
        for sigmaPower in [0..1] do
            for tauPowers in CartesianProduct([[0,1] : i in [1..9]]) do
            // construct permutation
            tauComposed := &*[tauVec[i]^tauPowers[i] : i in [1..9]];
            phi_g := tauComposed * sigma^sigmaPower * rho^rhoPower; // hopefully this covers all group elements!
            // compute dMap (dummy map) of the ideal P
            phi_g_P := ActOnIdeal(phi_g, P);
            Append(~SymmetriesOfPList, phi_g_P);
            end for;
        end for;
    end for;
    return SymmetriesOfPList;
end function;


IdealsModSymmetry := [];
OrbitCount := [1,1,1,1,1,1,1,1]; // cheating and hard coding here bc otherwise the code is much more complex lol
for P in Plist do
    // compute some symmetry transformations of my ideal
    SymmetriesOfP := SymmetryList(P);
    // if one element of SymmetriesOfP in IdealsModSymmetry
    if exists(IndexInIMSOfsymmetricP){Index(IdealsModSymmetry,symmetricP) : symmetricP in SymmetriesOfP | symmetricP in IdealsModSymmetry} then
        OrbitCount[IndexInIMSOfsymmetricP] +:= 1;
    else // it's a new ideal!
        print("New ideal!");
        Append(~IdealsModSymmetry, P);
    end if;
end for;

"2 - Reduce by symmetries - loaded."
"Ideals mod symmetry:";
IdealsModSymmetry;
"Orbit count (default 1):";
OrbitCount;