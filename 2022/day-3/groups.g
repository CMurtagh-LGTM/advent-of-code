file_stream := InputTextFile("data.txt");

total_score := 0;

while(not IsEndOfStream(file_stream)) do
    lines := [Chomp(ReadLine(file_stream)), Chomp(ReadLine(file_stream)), Chomp(ReadLine(file_stream))];
    if fail in lines then
        break;
    else
        char := Iterated(lines, Intersection);

        total_score := total_score + NumbersString(char, 52, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")[2];
    fi;
od;

Print(total_score);
