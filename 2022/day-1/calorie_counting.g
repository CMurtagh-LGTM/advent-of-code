file_stream := InputTextFile("data.txt");

elves := [[]];

i := 1;
while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    elif not line = "" then
        Add(elves[i], Int(line));
    else
        i := i + 1;
        elves[i] := [];
    fi;
od;

elves_total := List(elves, x->Sum(x));
Sort(elves_total);
elves_total := Reversed(elves_total);

max_calories := elves_total[1];
max_three_calories := elves_total[1] + elves_total[2] + elves_total[3];

Print(max_calories);
