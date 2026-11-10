// load "chapterIV/A_SetupMonomialBases.m";

load "SetupX.m";

runOutput := false;

// Convert purported basis for W to a matrix by storing basis vectors as rows.

//// 1. write the basis
monCubics := MonomialsOfDegree(S,3, {g: g in GroebnerBasis(defIdeal)}); // a la JV
"# cubics (expect 165-54 = 111):"; #monCubics; // 111 as expected (from Koszul arguments).

mons := MonomialsOfDegree(S,3);
"# number of total mon (expect 11 choose 3 = 165)";#mons;


/* complementary basis:
method 1: use complementary pivots

method 2: try x_i f_j and hope it is complementary to monCubics (=W). Started: 8.03am

in the end we did method 2. We got lucky: the monCubics (=W) are given as pure monomials,
so they are the same as if we did x_i f_j (=X) and THEN asked for complementary pivots.
*/
monRelns := [];

for i := 1 to 9 do
    xi := S.i;
    for j := 1 to 6 do
        fj := [f1,f2,f3,f4,f5,f6][j];
        guy := xi * fj;
        Append(~monRelns, guy);
    end for;
end for;

monBig := monRelns cat monCubics;

T := Matrix(QQ, [[MonomialCoefficient(f, m) : m in mons]: f in monBig]); // COB matrix

if runOutput then
    Rank(T);
    #monBig;
    if Rank(T) eq #monBig and #monBig eq #mons then
        "All x_i f_j and cubics-on-X are LI:";
        printf "Rank = "; #mons;
        end if;
    #mons;
end if;

// Create: 
// xi fj matrix (to check rank = 54)


// change of basis matrix T


// then actually repeat all the above steps but with 2-forms instead. (maybe omit Omega.)


// Check that all the bottom 111 rows of T are purely monomial.
dum := [&+[1 : c in Eltseq(T[i]) | c ne 0] : i in [55..165]]; // (counts nnz entries) // Eltseq flattens

if runOutput then
dum;
// > outputs [1,1,1,1,1...] so its monomial
end if;

BX_mons := [mons[Min([j : j in [1..Ncols(T)] | T[i,j] ne 0])]: i in [55..165]];
if runOutput then
BX_mons;
end if;