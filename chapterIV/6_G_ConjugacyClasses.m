// load "Week6/6_G_ConjugacyClasses.m";

// Defining constituent
D4 := DihedralGroup(4); // H
ZZmod2 := AdditiveGroup(ResidueClassRing(2)); // N
ZZmod2to9 := CartesianPower(ZZmod2, 9); // can maybe also do AbelianGroup
    // C28 := CartesianPower(ZZmod2, 8); // can maybe also do AbelianGroup
C28 := AbelianGroup([2,2,2,2,2,2,2,2]);
C29 := AbelianGroup([2,2,2,2,2,2,2,2,2]);

/* we now define our automorphic action (our section).
I just need AN automorphism, 
which WILL become conjugation in the larger group. 
Q: 
what is the actual effect of the conjugation I want? 
i.e. do conjugation in the external group which I have, 
then work out how that affected h,n; 
then construct that as an automorphism.

I don't think it matters if I useC28 or ZZmod2to9... hopefully!

*/
// generators take 1:
aF := C29.1;bF := C29.2;cF := C29.3;dF := C29.4;eF := C29.5;fF := C29.6;gF := C29.7;hF := C29.8;iF := C29.9;
// quotient by C2 = <tau_a tau_b ... tau_i>
prodFlip := aF+bF+cF+dF+eF+fF+gF+hF+iF; // magma formalises it additively (0,1)
C21 := sub<C29 | prodFlip>;
C29mC2, q := quo<C29 | C21>;  // C_2^9 mod C_2
// generators take 2: (read "quotient [image of] a Flip")
qaF := q(aF); qbF := q(bF); qcF := q(cF); qdF := q(dF); qeF := q(eF); qfF := q(fF); qgF := q(gF); qhF := q(hF); qiF := q(iF);

// For each generator of D4 construct an automorphism Aut(C29mC2)

rhoAut := hom<C29mC2 -> C29mC2 | 
// qaF -> qcF, <-- omit action of a since qaF = qbF ... qiF in quotient
qcF -> qiF,
qiF -> qgF, 
qgF -> qaF,
qbF -> qfF,
qfF -> qhF,
qhF -> qdF,
qdF -> qbF,
qeF -> qeF>;
/* 
the purpose of that is to build the automorphism that looks like 
conjugation: t |-> rho t rho^-1 in the semidirect product. 
so for example flipping the top left entry a, if I conjugate by rho (ccw),
this becomes a flip of the top right entry c. rhoAut is not itself clockwise; 
it sends flips in the opposite way because that's exactly how conjugation works.
*/ 
// Claude says that SemidirectProduct uses rho^-1 n rho, not what I said.
// Let's fix this:
rhoAut := hom<C29mC2 -> C29mC2 | 
qcF -> qaF,
qiF -> qcF,
qgF -> qiF, 
// qaF -> qgF, <-- omit action of a since qaF = qbF ... qiF in quotient
qfF -> qbF,
qhF -> qfF,
qdF -> qhF,
qbF -> qdF,
qeF -> qeF>;


tAut := hom<C29mC2 -> C29mC2 |
// qaF -> qgF, <-- omit action of a since qaF = qbF ... qiF in quotient
qbF -> qhF,
qcF -> qiF,
qgF -> qaF,
qhF -> qbF,
qiF -> qcF,
qdF -> qdF,
qeF -> qeF,
qfF -> qfF
>;

// // then make the D8 -> Aut(C_2^9 / C_2) map.
rho := D4.1;
t := D4.2;
assert rho^4 eq Id(D4); assert t^2 eq Id(D4); assert t*rho*t^(-1) eq rho^(-1);

phiHN := hom< D4 -> AutomorphismGroup(C29mC2) |
rho -> rhoAut,
t -> tAut
>;
// conjugation := hom<C28 -> Aut(D8) | flipvec -> 
//     hom<D4 -> D4 | d -> flipvec * d * flipvec^-1
//     >;
G, emb_C29mC2, emb_D4, proj_D4 := SemidirectProduct(C29mC2, D4, phiHN);

printf "num. CC = "; #ConjugacyClasses(G);
// ConjugacyClasses(G);








/* Need labels for the generators of G! (So that I can interpret the cc labels.)  */
gens := Setseq(Generators(G));

runOutput := false;
if runOutput then
    myGens := [
        <"qaF", emb_C29mC2(qaF)>,
        <"qbF", emb_C29mC2(qbF)>,
        <"qcF", emb_C29mC2(qcF)>,
        <"qdF", emb_C29mC2(qdF)>,
        <"qeF", emb_C29mC2(qeF)>,
        <"qfF", emb_C29mC2(qfF)>,
        <"qgF", emb_C29mC2(qgF)>,
        <"qhF", emb_C29mC2(qhF)>,
        <"qiF", emb_C29mC2(qiF)>,
        <"rho", emb_D4(rho)>,
        <"t",   emb_D4(t)>
    ];

    for x in myGens do
        for i in [1..#gens] do
            if gens[i] eq x[2] then
                print x[1], " -> G generator ", i;
            end if;
        end for;
    end for;
    end if;


// emb_qaF := gens[Index(gens, embC29mC2(qaF))]; <-- again. a is not a generator!
emb_qbF := gens[Index(gens, emb_C29mC2(qbF))]; // G.1
emb_qcF := gens[Index(gens, emb_C29mC2(qcF))]; // G.2
emb_qdF := gens[Index(gens, emb_C29mC2(qdF))]; // G.3
emb_qeF := gens[Index(gens, emb_C29mC2(qeF))]; // G.4 
emb_qfF := gens[Index(gens, emb_C29mC2(qfF))]; // G.5
emb_qgF := gens[Index(gens, emb_C29mC2(qgF))]; // G.6
emb_qhF := gens[Index(gens, emb_C29mC2(qhF))]; // G.7
emb_qiF := gens[Index(gens, emb_C29mC2(qiF))]; // G.8
emb_rho := gens[Index(gens, emb_D4(rho))];     // G.9
emb_t   := gens[Index(gens, emb_D4(t))];       // G.10

ccs := ConjugacyClasses(G);
ConjClassReps := [cc[3] : cc in ccs];