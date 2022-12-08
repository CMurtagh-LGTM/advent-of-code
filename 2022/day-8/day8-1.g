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
scenic_debug := List([1..99], x->EmptyPlist(99));

for x in [1..99] do
    for y in [1..99] do
        a := 0;
        for xi in [x+1..99] do
            a := a + 1;
            if trees[y][xi] >= trees[y][x] then
                break;
            fi;
        od;
        b := 0;
        for xi in [x-1, x-2..1] do
            b := b + 1;
            if trees[y][xi] >= trees[y][x] then
                break;
            fi;
        od;
        c := 0;
        for yi in [y+1..99] do
            c := c + 1;
            if trees[yi][x] >= trees[y][x] then
                break;
            fi;
        od;
        d := 0;
        for yi in [y-1, y-2..1] do
            d := d + 1;
            if trees[yi][x] >= trees[y][x] then
                break;
            fi;
        od;
        potential := a * b * c * d;
        scenic_debug[y][x] := potential;
        if potential > scenic then
            Print(potential, ", ", scenic, " ", x , ",", y, "\n");
            scenic := potential;
        fi;
    od;
od;

Print(scenic, "\n");
