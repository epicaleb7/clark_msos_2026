// load "Step2/lib/ReduceByG.m";
// Needs S, a..i from SetupX.m.

// G := SemidirectProduct(ZZmod2to9, D8, conjugation);
rhoHom := hom<S -> S | [c,f,i,b,e,h,a,d,g]>; // rotate cw
sigmaHom := hom<S -> S | [g,h,i,d,e,f,a,b,c]>; // flip about x-axis
tauVecHom := [hom<S -> S | [j eq i select -S.j else S.j : j in [1..9]]> : i in [1..9]];


// action of G on an ideal:
ActOnIdealQQ := function(phi, J)
    gens := Generators(J);
    new_gens := [S ! phi(f) : f in gens ];
    return Ideal(new_gens);
end function;

GOrbitQQ := function(P)
    SymmetriesOfPList := [];
    for rhoPower in [0..3] do
        for sigmaPower in [0..1] do
            for tauPowers in CartesianProduct([[0,1] : i in [1..9]]) do
            // construct permutation
            tauComposed := &*[tauVecHom[i]^tauPowers[i] : i in [1..9]];
            phi_g := tauComposed * sigmaHom^sigmaPower * rhoHom^rhoPower; // hopefully this covers all group elements!
            // compute dMap (dummy map) of the ideal P
            phi_g_P := ActOnIdealQQ(phi_g, P);
            Append(~SymmetriesOfPList, phi_g_P);
            end for;
        end for;
    end for;
    return SymmetriesOfPList;
end function;

hardcodedsizeoforbitcountieexpectedamximumsizeofGIMS := 100;

// Input: a list of ideals of S (i.e. over QQ), e.g. RadicalDecomposition(defIdeal + Ideal(a)).
// Output: GIMS = one representative per G-orbit, OC = how many of the input ideals lie in each orbit.
ReduceByG := function(Plist)
    // Guard: passing QQ(zeta8) ideals here (or QQ ideals to ReduceByGInQQal) silently gives
    // OC = [1,1,...,1], because ideals over different rings never compare equal.
    // That is exactly what caused the "anomalous b=h behaviour" (notes C1:22-24).
    error if #Plist gt 0 and Generic(Plist[1]) cmpne S,
        "ReduceByG expects ideals of S (over QQ). For ideals of Sal use ReduceByGInQQal.";
try
    GenericIdealsModSymmetry := [];
    OrbitCount := [1: i in [0..hardcodedsizeoforbitcountieexpectedamximumsizeofGIMS]]; // otherwise the code is more complex lol
    for P in Plist do
        // compute some symmetry transformations of my ideal
        SymmetriesOfP := GOrbitQQ(P);
        // if one element of SymmetriesOfP in GenericIdealsModSymmetry
        if exists(IndexInGIMSOfsymmetricP){
            Index(GenericIdealsModSymmetry,symmetricP) :
            symmetricP in SymmetriesOfP |
            symmetricP in GenericIdealsModSymmetry
            } then
            OrbitCount[IndexInGIMSOfsymmetricP] +:= 1;
        else // it's a new ideal!
            // print("New ideal!");
            Append(~GenericIdealsModSymmetry, P);
        end if;
    end for;
    return GenericIdealsModSymmetry, OrbitCount[1..#GenericIdealsModSymmetry];
catch e
    "Did you put in a RadicalDecomposition into the input??";
end try;
end function;
// Idea of above exists(){} thing: loop through elements of the G orbit of P. If any occurs also in the GIMS we've already seen, then update the OrbitCount at that index by +1.
// more concisely: if there exists something in the G orbit of P that already exists in the GIMS, then update the count (stored separately) of that corresponding GIMS representative by +1.

"Reduce generic ideal by symmetries - loaded as ReduceByG.";
