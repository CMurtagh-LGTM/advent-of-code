file_stream := InputTextFile("data.txt");

metric := function(v, u)
    return Maximum(AbsoluteValue(v[1]-u[1]), AbsoluteValue(v[2]-u[2]));
end;

knots := List([1..10], x->[0, 0]);

visited := rec(("0,0") := 1);

max := [0,0];
min := [0,0];

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        command := SplitString(line, " ");
        if command[1] = "R" then
            knots[1][1] := knots[1][1] + Int(command[2]);
        elif command[1] = "L" then
            knots[1][1] := knots[1][1] - Int(command[2]);
        elif command[1] = "U" then
            knots[1][2] := knots[1][2] + Int(command[2]);
        elif command[1] = "D" then
            knots[1][2] := knots[1][2] - Int(command[2]);
        else
            Error("Invalid Command", command[1]);
        fi;

        for i in [2..10] do
            while metric(knots[i-1], knots[i]) > 1 do
                knots[i] := knots[i] + List(knots[i-1] - knots[i], SignInt);
                if i = 10 then
                    visited.(Concatenation(String(knots[10][1]), ",", String(knots[10][2]))) := 1;
                fi;

                if knots[i][1] > max[1] then
                    max[1] := knots[i][1];
                elif knots[i][1] < min[1] then
                    min[1] := knots[i][1];
                fi;
                if knots[i][2] > max[2] then
                    max[2] := knots[i][2];
                elif knots[i][2] < min[2] then
                    min[2] := knots[i][2];
                fi;
            od;
        od;
    fi;
od;

disp := List([min[1]..max[1]], x->[]);
for x in [min[1]..max[1]] do
    for y in [min[2]..max[2]] do
        if IsBound(visited.(Concatenation(String(x), ",", String(y)))) then
            if x = y and y = 0 then
                disp[x-min[1]+1][y-min[2]+1] := 's';
            else
                disp[x-min[1]+1][y-min[2]+1] := '#';
            fi;
        else
            disp[x-min[1]+1][y-min[2]+1] := '.';
        fi;
    od;
od;

score := Length(RecNames(visited));

Print(score);

