// load "chapterIV/D4_only/D4_C_ComputeMatrices.m";

load "chapterIV/B_GroupIndFunctions.m";


// ------ Correspond Permutation-group-on-256-objects back to Act-on-x  ------
tInD4 := D4.2; // to disambiguate from t in semidirect product
rhoInD4 := D4.1;
function DecomposeD4(d4Elt) // turn permutationgroupelt into homomorphism index
    // loop through and check
    for tPow in [0,1] do
        for rhoPow in [0..3] do
            if d4Elt eq tInD4^tPow * rhoInD4^rhoPow then 
                return tPow, rhoPow; // returns powers to put on homomorphisms
            end if;
        end for;
    end for;
    error "d4Elt not of the form t^tPow * rho^rhoPow";
end function;

// function DecomposeC28(flipAbstractEltC28)
//     flipC29 := flipAbstractEltC28 @@ q; // take some preimage in C29 // e.g. tau1 tau4 tau5 .. tau9
//     coords := [Integers()!c : c in Eltseq(flipC29)]; // e.g. [1,0,0,1,1,1,1,1,1]

//     // fix to the even-weight rep (same coset) if nec
//     if (&+coords) mod 2 eq 1 then  // e.g. 1 eq 1
//         flipC29 := flipC29 + prodFlip;
//         coords := [Integers()!c : c in Eltseq(flipC29)]; // e.g. [0,1,1,0,0,0,0,0,0]
//     end if;
//     return coords;
// end function;







function calculate_matrix_and_trace_D4(ccRep);
    // by uniqueness of factorisation we can find the unique factors
    // d4Factor := proj_D4(ccRep);
    // c28Factor := (ccRep * emb_D4(d4Factor)^-1) @@ emb_C29mC2; // invert then take some pre-image
    // then correspond to a vector to use like in old loop.
    tPow, rhoPow := DecomposeD4(ccRep);
    // tauPowers := DecomposeC28(c28Factor);

    // Prepare for group action
    // tauComposed := &*[tauVecHom[i]^tauPowers[i] : i in [1..9]];
    
    Prod := a*b*c*d*e*f*g*h*i;
    // flipOnProd := MonomialCoefficient(tauComposed(Prod),Prod);
    flipOnProd := 1;
    assert flipOnProd eq 1;
    totalFlip := (-1)^tPow * flipOnProd;
    // assert tauComposed(Prod) eq flipOnProd * Prod;
    /* 
    The only group element action that affects Omega/Prod are
    t (flips it) and
    if tau has an odd number of flips (which by convention it shouldn't!)
    */ 
    g_hom := tHom^tPow * rhoHom^rhoPow;

    trace_of_cc := 0;
    father1 := Parent(GroupActOnMonomialVec(XRowsOfT[1], g_hom, totalFlip));
    matrix := ZeroMatrix(BaseRing(father1), Nrows(XRowsOfT), Nrows(XRowsOfT));
    for i in [1..Nrows(XRowsOfT)] do
        b_i := XRowsOfT[i];
        g_i := GroupActOnMonomialVec(b_i, g_hom, totalFlip);
        // Nrows(g_i); Ncols(g_i);
        // Nrows(matrix);Ncols(matrix);
        matrix[i] := g_i;
        // g_i;
        // Is g_i represented in the basis of b_i's? Yes I think so.
        trace_of_cc +:= g_i[i];
    end for;
    // print "Debug tPow, rhoPow, tauPow, matrix.";
    // printf "tPow:";tPow;
    // printf "rhoPow:";rhoPow;
    // printf "tauPow:";tauPowers;
    // print Rank(matrix);
    // matrix;
    return matrix, trace_of_cc;
end function;



// Search through conjugacy-class representatives until the desired
// (tPow, rhoPow, tauPowers) occurs, and print the index.

// error '';
// ------ Implement Algorithm on conjugacy class reps only ------
// (ConjClasReps should already be [c[3] : c in ConjugacyClasses(A)] from the loaded script)

ccsD4 := ConjugacyClasses(D4);
ConjClassRepsD4 := [cc[3] : cc in ccsD4];
trace_of_ccs_list := [];
for ccRep in ConjClassRepsD4 do
    matrix, trace_of_cc := calculate_matrix_and_trace_D4(ccRep);
    Append(~trace_of_ccs_list,trace_of_cc);
end for;

// Calculate this character function
trace_of_ccs_list;
chi_Omg2 := Vector(trace_of_ccs_list);


CT := CharacterTable(D4);
CharTableMatrix := Matrix([
    Eltseq(chi) 
    : chi in CT]);
assert Nrows(CharTableMatrix) eq Ncols(CharTableMatrix) and Nrows(CharTableMatrix) eq #ConjugacyClasses(D4);


father := Parent(CharTableMatrix[1][1]); // some cyclotomic field thing
chi_Omg2 := Vector([father!x: x in Eltseq(chi_Omg2)]);
sol := Solution(CharTableMatrix,chi_Omg2);
sol;
multiplicity_list := [Integers()! x : x in Eltseq(sol) | x ne 0];