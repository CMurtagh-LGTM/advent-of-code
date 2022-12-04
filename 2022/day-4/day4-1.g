file_stream := InputTextFile("data.txt");

total_score := 0;
total_overlap := 0;

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        sections := List(SplitString(line, ","), x->SplitString(x, "-"));
        s1 := [Int(sections[1][1])..Int(sections[1][2])];
        s2 := [Int(sections[2][1])..Int(sections[2][2])];

        intersection := Intersection(s1, s2);

        if intersection = s1 or intersection = s2 then
            total_score := total_score + 1;
        fi;

        if not intersection = [] then
            total_overlap := total_overlap + 1;
        fi;
    fi;
od;

Print(total_score, "\n");
Print(total_overlap);
