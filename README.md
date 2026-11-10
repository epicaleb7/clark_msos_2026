# msos_clark_2026

Magma code for the computations in my MSOS 2026 thesis (C. Clark).

Run with Magma V2.29-6.

## Running

All `load` paths are relative to this folder. Start Magma here:

```
cd msos_clark_2026
magma
```

or, inside Magma, `ChangeDirectory("<path to this folder>");` once. Then load any file
using the path in its first-line comment, e.g.

```
load "chapterIII/C2_Singularities/C2_ClassifySing.m";
```

`SetupX.m` defines the ideal of X over QQ; `SetupX_QQal.m` the same over QQ(zeta_8).

Particularly in Chapter IV, there are multiple dependent scripts, but all scripts load all relevant load scripts to them. So, for instance, to run the code that gives the decomposition of $\Omega_\mathrm{hol}^2(\widetilde{X})$, you need only run 'Step D' of `chapterIV/D_GModule.m`; A,B,C are dependencies that are loaded automatically.

## Layout

- `chapterII/`: ideal of the lines
- `chapterIII/C2_Singularities/`: Sing(X)
- `chapterIII/C1_Degeneracies/`: degeneracies, one file per case, over `QQ`, `QQ zeta8` = $\mathbb{Q}(\zeta_8) = \mathbb{Q}(\sqrt 2, i)$ and `QQ zeta24` = $\mathbb{Q}(\zeta_{24}) = \mathbb{Q}(\zeta_8,\sqrt{3})$, with saved output
- `chapterIII/lib/`: A-orbit reduction helpers
- `chapterIV/`: group action, characters, decomposition
- `chapterIV/_LemmaB.m`: Jacobian-minor check for Lemma (number) (local coordinates when P lies in exactly one line)
- `chapterIV/D4_only`: characters and decomposition for restriction representation of $D_4 \leq A$
- `chapterIV/D4_only`: characters and decomposition for restriction representation of $G=(C_2^9)_\mathrm{even} \leq A$