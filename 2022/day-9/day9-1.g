file_stream := InputTextFile("data.txt");

metric := function(v, u)
    return Maximum(AbsoluteValue(v[1]-u[1]), AbsoluteValue(v[2]-u[2]));
end;

normal := function(v)
    return List(v, SignInt);
end;

head := [0, 0];
tail := [0, 0];

visited := rec(("0,0"):=1);

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        command := SplitString(line, " ");
        if command[1] = "R" then
            head[1] := head[1] + Int(command[2]);
        elif command[1] = "L" then
            head[1] := head[1] - Int(command[2]);
        elif command[1] = "U" then
            head[2] := head[2] + Int(command[2]);
        elif command[1] = "D" then
            head[2] := head[2] - Int(command[2]);
        else
            Error("Invalid Command", command[1]);
        fi;

        while metric(head, tail) > 1 do
            tail := tail + normal(head - tail);
            visited.(Concatenation(String(tail[1]), ",", String(tail[2]))) := 1;
        od;
    fi;
od;

score := Length(RecNames(visited));

Print(score);
