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
load "Step2/C2_Singularities/C2_ClassifySing.m";
```

`SetupX.m` defines the ideal of X over QQ; `SetupX_QQal.m` the same over QQ(zeta_8).

## Layout

- `chapterII/`: ideal of the lines (note that this was in chapterIII, so this is currently wrong!)
- `chapterIII/C2_Singularities/`: Sing(X)
- `chapterIII/C1_Degeneracies/`: degeneracies, one file per case, over `QQ`, `QQ zeta8` = QQ(zeta_8) and `QQ zeta24` = QQ(zeta_24) = QQ(zeta_8, sqrt 3), with saved output
- `chapterIII/lib/`: G-orbit reduction helpers
- `chapterIV/`: group action and characters, plus one file for Jacobian-minor check for Lemma B.
