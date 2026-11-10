// load "chapterIV/D4_only/D4_D_GModule.m";

// Here the irred modules are labelled by E (not D!).

load "chapterIV/D4_only/D4_C_ComputeMatrices.m";

chi_Omega2 := CharacterRing(D4) ! trace_of_ccs_list;   // turns the list of traces into a character of D4
mats := [];
for j in [1..Ngens(D4)] do
    M, _ := calculate_matrix_and_trace_D4(D4.j);
    Append(~mats, M);
end for;
diff2Forms := GModule(D4, mats);
assert Character(diff2Forms) eq chi_Omega2; // just to check two independent ways of calculating it are the same
assert Eltseq(sol) eq Eltseq(Decomposition(CT, chi_Omega2));

"========= Decomposition =========";
decompD4 := Decomposition(CT, Character(diff2Forms)); 
decompD4;
summandsD4only := Decomposition(diff2Forms);
indecompSummandsD4only := IndecomposableSummands(diff2Forms);
// these are both just a WHOLE bunch of "GModule of dimension 1 over Rational Field". (57 of dimension 1 + 27 of dimension 2).
// We can at least check they're equal:
indecompSummandsD4only eq summandsD4only; // true bc semisimple I think?


/*
"========= Interpreting submodules example =========";
[Dimension(Mi) : Mi in summands];
k := 3;
E_k := summands[k];
iota_k := Morphism(E_k, diff2Forms);
iota_k_mat := Matrix(iota_k); // rows = basis of summand k, in diff2form's basis
ActionGenerator(E_k, 1); // matrix of A.1 on summand k // this is another way to check the matrices are right.
assert iota_k_mat * ActionGenerator(diff2Forms, 1) eq ActionGenerator(summands[k], 1) * iota_k_mat;
*/



"======== Loop through inclusion matrices =========";
for k in [1..#summandsD4only] do
    "k =", k;
    E_k := summandsD4only[k];
    "Dimension =", Dimension(E_k);
    "Isomorphism class (character): χ_", [n : n in [1..#CT] | CT[n] eq Character(E_k)][1]; // index n for which our irred module has character eq to (the irreducible character) chi_n
    iota_k := Morphism(E_k, diff2Forms);
    iota_k_mat := Matrix(iota_k);
    "Basis elements (in terms of Omg/Prod):";
    for r in [1..Nrows(iota_k_mat)] do
        "row",r,":";
        [iota_k_mat[r][j] * monCubics[j] : j in [1..111] | iota_k_mat[r][j] ne 0]; // index = iota_k_mat[r][j]
    end for;
    '';'';'';
end for;