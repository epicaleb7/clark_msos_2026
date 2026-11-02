// load "Week6/6B_GModule.m";

error if not assigned chi_R3, "Run: load \"Week6/6B_Clean.m\"; first";
// load "Week6/6B_Clean.m";

chi_Omega2 := CharacterRing(G) ! trace_of_ccs_list;   // turns the list of traces into a character of G
mats := [];
for j in [1..Ngens(G)] do
    M, _ := calculate_matrix_and_trace(G.j);
    Append(~mats, M);
end for;
diff2Forms := GModule(G, mats);
assert Character(diff2Forms) eq chi_Omega2; // just to check!
assert Eltseq(sol) eq Eltseq(Decomposition(CT, chi_Omega2));

"========= Decomposition =========";
Decomposition(CT, Character(diff2Forms)); 
summands := Decomposition(diff2Forms);
indecompSummands := IndecomposableSummands(diff2Forms);
assert indecompSummands eq summands; // true bc semisimple I think?


"========= Interpreting submodules =========";
[Dimension(Mi) : Mi in summands];
k := 3;
D_k := summands[k];
iota_k := Morphism(D_k, diff2Forms);
iota_k_mat := Matrix(iota_k); // rows = basis of summand k, in diff2form's basis
ActionGenerator(D_k, 1); // matrix of G.1 on summand k
assert iota_k_mat * ActionGenerator(diff2Forms, 1) eq ActionGenerator(summands[k], 1) * iota_k_mat;

/*
4 = e = id
1,7=b,h = flip top left
    rho = flip two bases


*/


"======== Loop through inclusion matrices =========";
for k in [1..#summands] do
    "k =", k;
    D_k := summands[k];
    "Dimension =", Dimension(D_k);
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

error '';