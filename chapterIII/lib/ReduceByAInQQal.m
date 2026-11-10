// load "chapterIII/lib/ReduceByAInQQal.m";
// Needs Sal, a_al..i_al from SetupX_QQal.m.

// A := SemidirectProduct(ZZmod2to9, D8, conjugation);
rho := hom<Sal -> Sal | [c_al,f_al,i_al,b_al,e_al,h_al,a_al,d_al,g_al]>; // rotate cw
sigma := hom<Sal -> Sal | [g_al,h_al,i_al,d_al,e_al,f_al,a_al,b_al,c_al]>; // flip about x-axis
tauVec := [hom<Sal -> Sal | [j eq i select -Sal.j else Sal.j : j in [1..9]]> : i in [1..9]]; // (27 Sep: was S.j, fixed to Sal.j)

// action of A on an ideal:
ActOnIdealQQal := function(phi, J)
    gens := Generators(J);
    new_gens := [Sal ! phi(f) : f in gens ];
    return Ideal(new_gens);
end function;

AOrbitQQal := function(P)
    SymmetriesOfPList := [];
    for rhoPower in [0..3] do
        for sigmaPower in [0..1] do
            // only 8 of the 9 sign flips: flipping all 9 fixes every homogeneous ideal (projectively the identity)
            for tauPowers in CartesianProduct([[0,1] : i in [1..8]]) do
            // construct permutation
            tauComposed := &*[tauVec[i]^tauPowers[i] : i in [1..8]];
            phi_g := tauComposed * sigma^sigmaPower * rho^rhoPower; // hopefully this covers all group elements!
            // compute dMap (dummy map) of the ideal P
            phi_g_P := ActOnIdealQQal(phi_g, P);
            Append(~SymmetriesOfPList, phi_g_P);
            end for;
        end for;
    end for;
    return SymmetriesOfPList;
end function;

hardcodedsizeoforbitcountieexpectedamximumsizeofGIMS := 1000;

// Input: a list of ideals of Sal (over QQ(zeta8)), e.g. RadicalDecomposition(defIdealal + Ideal(a_al)).
// Output: GIMS = one representative per A-orbit, OC = how many of the input ideals lie in each orbit.
ReduceByAInQQal := function(Plist)
    // Guard: see the comment in ReduceByA.m (this is the "anomalous b=h" bug).
    error if #Plist gt 0 and Generic(Plist[1]) cmpne Sal,
        "ReduceByAInQQal expects ideals of Sal (over QQ(zeta8)). For ideals of S use ReduceByA.";
try
    GenericIdealsModSymmetry := [];
    OrbitCount := [1: i in [0..hardcodedsizeoforbitcountieexpectedamximumsizeofGIMS]]; // otherwise the code is more complex lol
    for P in Plist do
        // compute some symmetry transformations of my ideal
        SymmetriesOfP := AOrbitQQal(P);
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
catch errah
    // error e;
    print(errah);
    "Did you put in a RadicalDecomposition into the input?? Expect now a lack of return statement error as punishment.";
end try;
end function;

"Reduce generic ideal by symmetries In QQ_al - loaded as ReduceByAInQQal.";
