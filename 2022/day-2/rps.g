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
        us := NumbersString(values[2], 3, ['X', 'Y', 'Z'])[2];
        total_score := total_score + us;
        if (us = 1 and them = 3) or (us = 2 and them = 1) or (us = 3 and them = 2) then
            # Print(debug_map.(us), us, " ", debug_map.(them), " ", 6+us, "\n");
            total_score := total_score + 6;
        elif us = them then
            # Print(debug_map.(us), us, " ", debug_map.(them), " ", 3+us, "\n");
            total_score := total_score + 3;
        fi;
    fi;
od;

Print(total_score);
