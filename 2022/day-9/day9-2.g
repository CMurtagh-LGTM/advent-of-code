file_stream := InputTextFile("data.txt");

metric := function(v, u)
    return Maximum(AbsoluteValue(v[1]-u[1]), AbsoluteValue(v[2]-u[2]));
end;

knots := List([1..10], x->[0, 0]);

visited := rec(("0,0") := 1);

max := [224,16];
min := [-29,-248];
#max := [14,15];
#min := [-11,-5];

display := function()
    local x, y, i;
    # display this move
    disp := List([min[2]..max[2]], y->[]);
    for x in [min[1]..max[1]] do
        for y in [min[2]..max[2]] do
            for i in [10,9..1] do
                if knots[i] = [x,y] then
                    disp[y-min[2]+1][x-min[1]+1] := String(i-1)[1];
                fi;
            od;
            if not IsBound(disp[y-min[2]+1][x-min[1]+1]) then
                if IsBound(visited.(Concatenation(String(x), ",", String(y)))) then
                    disp[y-min[2]+1][x-min[1]+1] := '#';
                else
                    disp[y-min[2]+1][x-min[1]+1] := '.';
                fi;
            fi;
        od;
    od;

    Print(JoinStringsWithSeparator(Reversed(disp), "\n"), "\n\n");
end;

move_knots := function()
    local i;
    for i in [2..10] do
        while metric(knots[i-1], knots[i]) > 1 do
            knots[i] := knots[i] + List(knots[i-1] - knots[i], SignInt);
            if i = 10 then
                visited.(Concatenation(String(knots[10][1]), ",", String(knots[10][2]))) := 1;
            fi;
        od;
    od;
    #display();
end;

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        command := SplitString(line, " ");
        if command[1] = "R" then
            for i in [1..Int(command[2])] do
                knots[1][1] := knots[1][1] + 1;
                move_knots();
            od;
        elif command[1] = "L" then
            for i in [1..Int(command[2])] do
                knots[1][1] := knots[1][1] - 1;
                move_knots();
            od;
        elif command[1] = "U" then
            for i in [1..Int(command[2])] do
                knots[1][2] := knots[1][2] + 1;
                move_knots();
            od;
        elif command[1] = "D" then
            for i in [1..Int(command[2])] do
                knots[1][2] := knots[1][2] - 1;
                move_knots();
            od;
        else
            Error("Invalid Command", command[1]);
        fi;
    fi;
od;

score := Length(RecNames(visited));

Print(score);

