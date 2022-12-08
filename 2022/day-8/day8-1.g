file_stream := InputTextFile("data.txt");

trees := SplitString(ReadAll(file_stream), "\n");
trees := List(trees, x->List(x, y->Int([y])));

visible := List(trees, x->List(x, y->0));

for y in [1..99] do
    prev := -1;
    for x in [1..99] do
        if trees[y][x] > prev then
            prev := trees[y][x];
            visible[y][x] := 1;
        fi;
    od;

    prev := -1;
    for x in [99, 98..1] do
        if trees[y][x] > prev then
            prev := trees[y][x];
            visible[y][x] := 1;
        fi;
    od;
od;
for x in [1..99] do
    prev := -1;
    for y in [1..99] do
        if trees[y][x] > prev then
            prev := trees[y][x];
            visible[y][x] := 1;
        fi;
    od;

    prev := -1;
    for y in [99, 98..1] do
        if trees[y][x] > prev then
            prev := trees[y][x];
            visible[y][x] := 1;
        fi;
    od;
od;

total := Sum(Sum(visible));
Print(total, "\n");

scenic := 0;

for x in [1..99] do
    for y in [1..99] do
        potential := 1;
        a := 1;
        for xi in [x..99] do
            if trees[y][xi] < trees[y][x] then
                a := a + 1;
            else
                break;
            fi;
        od;
        potential := potential * Maximum(a, 1);
        a := 1;
        for xi in [1..x] do
            if trees[y][xi] < trees[y][x] then
                a := a + 1;
            else
                break;
            fi;
        od;
        potential := potential * Maximum(a, 1);
        a := 1;
        for yi in [y..99] do
            if trees[yi][x] < trees[y][x] then
                a := a + 1;
            else
                break;
            fi;
        od;
        potential := potential * Maximum(a, 1);
        a := 1;
        for yi in [1..y] do
            if trees[yi][x] < trees[y][x] then
                a := a + 1;
            else
                break;
            fi;
        od;
        potential := potential * Maximum(a, 1);
        if potential > scenic then
            scenic := potential;
            Print(x, ", ", y, "\n");
        fi;
    od;
od;

Print(scenic, "\n");
