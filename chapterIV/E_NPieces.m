// load "chapterIV/E_NPieces.m";
// Task 1: which N-isotypic pieces sit inside each A-summand D_k, where N = emb_C29mC2(C29mC2) ~ C2^8.
// Writes chapterIV/N_pieces_output.tex.

load "chapterIV/C_ComputeMatrices.m";
SetColumns(0); // no line wrapping in printed/written strings

mats := [];
for j in [1..Ngens(A)] do
    M, _ := calculate_matrix_and_trace_A(A.j);
    Append(~mats, M);
end for;
diff2Forms := GModule(A, mats);
summands := Decomposition(diff2Forms);

"========= Restrict to N and decompose =========";
N := sub<A | [emb_C29mC2(x) : x in Generators(C29mC2)]>;
assert #N eq 2^8;
W_N := Restriction(diff2Forms, N); // same 111-dim monCubics basis as diff2Forms
F := Decomposition(W_N);
"#F =", #F, "  dims of F's:", {* Dimension(Fl) : Fl in F *};

// group the F's by N-character (signs of the generators of N) -> isotypic components U_c
keys := [];
comps := [* *]; // comps[c] = U_c as a row space in the 111-dim basis
for Fl in F do
    key := [Integers()! ActionGenerator(Fl, j)[1][1] : j in [1..Ngens(N)]];
    V := RowSpace(Matrix(Morphism(Fl, W_N)));
    pos := Index(keys, key);
    if pos eq 0 then
        Append(~keys, key); Append(~comps, V);
    else
        comps[pos] := comps[pos] + V;
    end if;
end for;
assert &+[Dimension(U) : U in comps] eq 111;
"# distinct N-characters (isotypic components U_c):", #comps;

// label each U_c by the exponent vector mod 2 of the monomials it contains,
// and check U_c is exactly the span of those monomials (canonical check of the grouping)
Amb := Generic(comps[1]);
parity := func< j | [e mod 2 : e in Exponents(monCubics[j])] >;
labels := [];
for c in [1..#comps] do
    supp := {j : j in [1..111] | &or[v[j] ne 0 : v in Basis(comps[c])]};
    pars := {parity(j) : j in supp};
    assert #pars eq 1;
    p := Rep(pars);
    assert comps[c] eq sub<Amb | [Amb.j : j in [1..111] | parity(j) eq p]>;
    Append(~labels, p);
end for;
// sort components by (dim, label) for a stable numbering
sortKey := func< x | 2^9 * Dimension(comps[x]) + &+[labels[x][n] * 2^(9-n) : n in [1..9]] >;
order := Sort([1..#comps], func< x, y | sortKey(x) - sortKey(y) >);
comps := [comps[c] : c in order]; labels := [labels[c] : c in order];
"<c, mod-2 label, dim U_c>:"; [<c, labels[c], Dimension(comps[c])> : c in [1..#comps]];

"========= Intersect each D_k with each U_c =========";
pieces := [* *]; // pieces[k] = [<c, D_k meet U_c>, ...]
for k in [1..#summands] do
    Vk := RowSpace(Matrix(Morphism(summands[k], diff2Forms)));
    Pk := [<c, Vk meet comps[c]> : c in [1..#comps] | Dimension(Vk meet comps[c]) gt 0];
    assert &+[Dimension(P[2]) : P in Pk] eq Dimension(Vk);
    Append(~pieces, Pk);
    "k =", k, " dim", Dimension(Vk), " -> <c, dim>:", [<P[1], Dimension(P[2])> : P in Pk];
end for;

"========= Write tex =========";
fname := "chapterIV/N_pieces_output.tex";
procedure out(s) PrintFile("chapterIV/N_pieces_output.tex", s); end procedure;
mgrid := func< ex | "\\mgrid{" cat &cat[Sprint(ex[n]) cat (n lt 9 select "," else "") : n in [1..9]] cat "}" >;
function coeffTeX(cf, first)
    sgn := cf lt 0 select "-" else (first select "" else "+");
    ab := Abs(cf);
    if ab eq 1 then body := "";
    elif Denominator(ab) eq 1 then body := Sprint(Numerator(ab));
    else body := Sprintf("\\tfrac{%o}{%o}", Numerator(ab), Denominator(ab));
    end if;
    if sgn cat body eq "" then return ""; end if;
    return "$" cat sgn cat body cat "$\\,";
end function;
function vecTeX(v)
    js := [j : j in [1..111] | v[j] ne 0];
    return &cat[coeffTeX(v[js[r]], r eq 1) cat mgrid(Exponents(monCubics[js[r]])) cat (r lt #js select " " else "") : r in [1..#js]];
end function;
irrepIndex := func< Dk | [n : n in [1..#CT] | CT[n] eq Character(Dk)][1] >;

PrintFile(fname, "\\documentclass[10pt]{article}" : Overwrite := true);
for s in [
    "\\usepackage[margin=1.5cm]{geometry}",
    "\\usepackage{amsmath,longtable,booktabs,tikz,xcolor}",
    "\\setlength{\\parindent}{0pt}",
    "\\definecolor{expone}{HTML}{3FAE49}",
    "\\definecolor{exptwo}{HTML}{F2C230}",
    "\\definecolor{expthree}{HTML}{D9412E}",
    "\\newcommand{\\mgrid}[1]{%",
    "  \\begin{tikzpicture}[baseline={([yshift=-0.5ex]current bounding box.center)},x=0.19cm,y=0.19cm]",
    "    \\foreach \\e [count=\\n from 0] in {#1} {",
    "      \\pgfmathtruncatemacro{\\gc}{mod(\\n,3)}",
    "      \\pgfmathtruncatemacro{\\gr}{div(\\n,3)}",
    "      \\ifcase\\e\\relax \\def\\fc{white}\\or\\def\\fc{expone}\\or\\def\\fc{exptwo}\\else\\def\\fc{expthree}\\fi",
    "      \\filldraw[fill=\\fc, draw=black!55, line width=0.35pt] (\\gc,-\\gr) rectangle ++(1,-1);",
    "    }",
    "  \\end{tikzpicture}}",
    "\\providecommand{\\tOmega}{\\widetilde{\\Omega}}",
    "\\begin{document}",
    "\\begin{center}{\\large\\bfseries Raw output of \\texttt{E\\_NPieces.m}: $N$-isotypic pieces of the $A$-summands}\\end{center}",
    "$N=\\texttt{emb\\_C29mC2(C29mC2)}\\cong C_2^8$. \\verb|W_N := Restriction(diff2Forms, N)|, \\verb|F := Decomposition(W_N)|"
        cat Sprintf(" gives %o summands, all of dimension 1.", #F),
    "The $F$'s are grouped by $N$-character into isotypic components $U_c$ (" cat Sprint(#comps) cat " of them), numbered by $(\\dim U_c,\\ \\text{label})$.",
    "Label of $U_c$: the exponent vector mod 2 (as a grid) shared by all monomials spanning $U_c$; the script asserts $U_c$ is exactly the span of the monomials with that label.",
    "Piece $=D_k\\cap U_c$ (\\texttt{meet}); its basis is Magma's echelonised \\verb|Basis(...)| in the \\texttt{monCubics} basis. For every $k$ the piece dimensions sum to $\\dim D_k$ (asserted).",
    "Column ``irrep'' is $\\chi_n$ with \\verb|CT[n] eq Character(D_k)|, $n$-th character of \\verb|CharacterTable(A)|.",
    "",
    "\\section*{Isotypic components $U_c$}",
    "{\\renewcommand{\\arraystretch}{1.5}",
    "\\begin{longtable}{@{}r c r@{}}",
    "\\toprule $c$ & label & $\\dim U_c$\\\\\\midrule\\endhead"
    ] do out(s); end for;
for c in [1..#comps] do
    out(Sprintf("%o & %o & %o\\\\", c, mgrid(labels[c]), Dimension(comps[c])));
end for;
for s in [
    "\\bottomrule\\end{longtable}}",
    "\\newpage",
    "\\section*{Pieces $D_k\\cap U_c$}",
    "{\\small",
    "\\renewcommand{\\arraystretch}{1.6}",
    "\\begin{longtable}{@{}r c c r c c p{0.6\\textwidth}@{}}",
    "\\toprule",
    "$k$ & $\\dim D_k$ & irrep & $c$ & label & $i$ & basis element $v_i/\\tOmega$ of $D_k\\cap U_c$\\\\\\midrule\\endhead"
    ] do out(s); end for;
for k in [1..#summands] do
    firstRowK := true;
    for P in pieces[k] do
        c := P[1];
        B := Basis(P[2]);
        for r in [1..#B] do
            colK := firstRowK select Sprintf("%o & %o & $\\chi_{%o}$", k, Dimension(summands[k]), irrepIndex(summands[k])) else " &  & ";
            colC := r eq 1 select Sprintf("%o & %o", c, mgrid(labels[c])) else " & ";
            out(Sprintf("%o & %o & %o & %o\\\\", colK, colC, r, vecTeX(B[r])));
            firstRowK := false;
        end for;
    end for;
    out("\\midrule");
end for;
for s in ["\\bottomrule", "\\end{longtable}}", "\\end{document}"] do out(s); end for;
"wrote", fname;
quit;
