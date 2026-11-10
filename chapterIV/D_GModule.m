// load "chapterIV/D_GModule.m";

// Here the irred modules are labelled by D.

load "chapterIV/C_ComputeMatrices.m";

chi_Omega2 := CharacterRing(A) ! trace_of_ccs_list;   // turns the list of traces into a character of A
mats := [];
for j in [1..Ngens(A)] do
    M, _ := calculate_matrix_and_trace_A(A.j);
    Append(~mats, M);
end for;
diff2Forms := GModule(A, mats); // genuinely used to find summands below.
assert Character(diff2Forms) eq chi_Omega2; // Check Magma's character agrees with the one we computed by hand
assert Eltseq(sol) eq Eltseq(Decomposition(CT, chi_Omega2));

"========= Decomposition ========="; // doesnt rely on GModule, just works out (character=irred) multiplicities
azz, bzz := Decomposition(CT, chi_Omega2); // does the linear algebra (using inner products and a canonical remainder)
"which intrinsic-A-irreducibles appear:";
"<index-as-an-A-irreducible, multiplicity>:";
[<i, azz[i]> : i in [1..#azz] | azz[i] ne 0];
"Remainder (should be 0):";bzz;

// Useful for interpretations (two equivalent ways to get this):
summands := Decomposition(diff2Forms);
indecompSummands := IndecomposableSummands(diff2Forms);
// these output a WHOLE bunch of "GModule of dimension 1 over Rational Field". (57 of dimension 1 + 27 of dimension 2).
// They are equal:
assert indecompSummands eq summands; // true bc semisimple I think?

'';'';
"========= Interpreting submodules =========";
"Dimensions of all Dk"; [Dimension(Dk) : Dk in summands];

// example computation
k := 3;
D_k := summands[k];
iota_k := Morphism(D_k, diff2Forms);
iota_k_mat := Matrix(iota_k); // rows = basis of summand k, in diff2form's basis
"Matrix for A.1 on irreducible summand D_",k; ActionGenerator(D_k, 1); // matrix of A.1 on summand k
assert iota_k_mat * ActionGenerator(diff2Forms, 1) eq ActionGenerator(summands[k], 1) * iota_k_mat;
// assert ActionGenerator(D_k, 1) eq calculate_matrix_and_trace_A(A.1)[1]; // check that Magma's post hoc matrices agree with my ad hoc matrices for the group elt A.1
// this is false. fix if i have time.

/*
4 = e = id
1,7=b,h = flip top left
    rho = flip two bases


*/


"----- Loop through inclusion matrices to give explicit description -----";
for k in [1..#summands] do
    "k =", k;
    D_k := summands[k];
    "Dimension =", Dimension(D_k);
    "Isomorphism class: X.", [n : n in [1..#CT] | CT[n] eq Character(D_k)][1]; // index n for which our irred module has character eq to (the irreducible character) chi_n
    // "Multiplicity =",multiplicity_list[k]; // broken since at +2 it counts only once. whereas summands counts twice.
    iota_k := Morphism(D_k, diff2Forms);
    iota_k_mat := Matrix(iota_k);
    "Basis elements (in terms of Omg/Prod):";
    for r in [1..Nrows(iota_k_mat)] do
        "row",r,":";
        [iota_k_mat[r][j] * monCubics[j] : j in [1..111] | iota_k_mat[r][j] ne 0]; // index = iota_k_mat[r][j]

    end for;
    '';'';'';
end for;


"========= Restricting each A-summand to D4 =========";
// Character table of D4 alone (same χ1..χ5 labels as in D4_only/).
CT_D4 := CharacterTable(D4);
CharTableMatrix_D4 := Matrix([Eltseq(chi) : chi in CT_D4]);
father_D4 := Parent(CharTableMatrix_D4[1][1]);
ConjClassRepsD4 := [cc[3] : cc in ConjugacyClasses(D4)];

total := [0,0,0,0,0];
for j in [1..#summands] do
    M_j := summands[j];
    rho_j := Representation(M_j); // A -> GL(M_j)

    // trace of each D4 class rep, pushed into A via emb_D4
    trace_list_j := [father_D4 ! Trace(rho_j(emb_D4(ccRep))) : ccRep in ConjClassRepsD4];

    // write that character in terms of the D4 irreducibles
    multiplicities_j := Solution(CharTableMatrix_D4, Vector(trace_list_j));
    total := [total[n] + Integers()!multiplicities_j[n] : n in [1..5]];

    if j ge 10 then string := ": dim"; else string := " : dim"; end if; // align whitespace
    "A-summand", j, string, Dimension(M_j), "--> with D4 multiplicities (χ1,..,χ5) =", multiplicities_j;
end for;

"Total D4 multiplicities:", total; // want [8,14,14,21,27] as per D4_only code



// sanity check `total' against D4-only code

/* ----- Load D4 only code ----- */
load "chapterIV/D4_only/D4_C_ComputeMatrices.m";

chi_Omega2 := CharacterRing(D4) ! trace_of_ccs_list;   // turns the list of traces into a character of D4
mats := [];
for j in [1..Ngens(D4)] do
    M, _ := calculate_matrix_and_trace_D4(D4.j);
    Append(~mats, M);
end for;
diff2Forms := GModule(D4, mats);
decompD4 := Decomposition(CT, Character(diff2Forms)); 
/* ----- Finish loading D4 only code ----- */

"matches D4_only code:", total[1] eq decompD4[1] and total[2] eq decompD4[2] and total[3] eq decompD4[3] and total[4] eq decompD4[4] and total[5] eq decompD4[5];