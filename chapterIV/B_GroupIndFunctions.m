// load "chapterIV/B_GroupIndFunctions.m";

load "chapterIV/A_SetupMonomialBases.m";
// load "chapterIII/lib/ReduceByA.m";
load "chapterIV/_GroupActionNewWay.m";

load "chapterIV/_ConjugacyClasses.m";


// Action of tau_m on diff 2-form basis.

// Given a 2-form as a vector with 165 coefficients
egcubic := monBig[1];
egvec := [MonomialCoefficient(egcubic, m) : m in mons]; // -a^3 - a*d^2 + a*h^2 + a*i^2
// output tau_m(egvec)

function theta(cubicForm, monomialBasis) // form -> vector
    coefficientVector := [MonomialCoefficient(cubicForm, m) : m in monomialBasis];
    return coefficientVector;
end function;

function thetaInv(coefficientVector, monomialBasis) // vector -> form
    return &+[coefficientVector[i] * monomialBasis[i]: i in [1..#monomialBasis]
                | coefficientVector[i] ne 0];
end function;
assert theta(egcubic,mons) eq egvec;
assert theta(thetaInv(egvec,mons),mons) eq egvec;

function thetaInvNice(coefficientVector, monomialBasis)
    seq := Eltseq(coefficientVector);
    nonzeroEntries := [i : i in [1..#seq] | seq[i] ne 0];
    assert #nonzeroEntries eq 1;
    i := nonzeroEntries[1];
    return seq[i] * monomialBasis[i];
end function;


// ------ Algorithm. (X6B:11,12) ------
XRowsOfT := Submatrix(T,55,1,111,165);
assert XRowsOfT eq Matrix(QQ, [theta(f,mons): f in monCubics]);

    // 1. Take b_i
function GroupActOnMonomialVec(b_i, g_hom, totalFlip)

    // 2. Convert into the monomial (apply theta^-1)
    thi_b_i := thetaInvNice(b_i,mons);

    // 3. Apply g via homomorhoPowhisms
    g_thi_b_i := totalFlip * (g_hom(thi_b_i));

    // 4. Apply theta
    th_g_thi_b_i := Vector(theta(g_thi_b_i, mons));

    // 5&6. Project, extract coefficients in b_j (of B_X) basis.
    assert IsConsistent(T,th_g_thi_b_i);
    g_i, _ := Solution(T,th_g_thi_b_i);
    
        // project: extract the last 111 coefficients!
    g_i := Vector(Eltseq(g_i)[55..165]);


    return g_i;
end function;