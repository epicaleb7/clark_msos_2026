// load "chapterIV/_GroupActionNewWay.m";

// Check SetupX is loaded.
require Names(S) eq ["a","b","c","d","e","f","g","h","i"] :
    "S must have variables a,b,c,d,e,f,g,h,i.";

// Implement homomorphisms.
rhoHom := hom<S -> S | [g,d,a,h,e,b,i,f,c]>; // rhotate ccw
tHom := hom<S -> S | [g,h,i,d,e,f,a,b,c]>; // x-axis flip
tauVecHom := [hom<S -> S | [j eq i select -S.j else S.j : j in [1..9]]> : i in [1..9]]; // flip i'th variable

// used in 6B.
