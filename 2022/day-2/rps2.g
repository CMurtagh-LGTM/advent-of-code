file_stream := InputTextFile("data.txt");

scores := rec(X:=1,Y:=2,Z:=3);

total_score := 0;

debug_map := rec(1 := "Rock", 2 := "Paper", 3 := "Scissors");

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        values := SplitString(line, " ");
        them := NumbersString(values[1], 3, ['A', 'B', 'C'])[2];
        target := NumbersString(values[2], 3, ['X', 'Y', 'Z'])[2];
        if target = 3 then
            total_score := total_score + 6;
        elif target = 2 then
            total_score := total_score + 3;
        fi;
        us := (them + target - 2) mod 3;
        if us = 0 then us := 3; fi;
        Print(debug_map.(us), " ", debug_map.(them), " ", target, "\n");
        total_score := total_score + us;
    fi;
od;

Print(total_score);
