file_stream := InputTextFile("data.txt");

total_score := 0;

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        line := Chomp(line);
        compartment_1 := line{[1..Length(line)/2]};
        compartment_2 := line{[(Length(line)/2+1)..Length(line)]};

        char := Intersection(compartment_1, compartment_2);

        total_score := total_score + NumbersString(char, 52, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")[2];
    fi;
od;

Print(total_score);
