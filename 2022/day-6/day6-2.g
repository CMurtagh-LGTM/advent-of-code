file_stream := InputTextFile("data.txt");

last14 := [];
i := 0;

data := ReadAll(file_stream);

for byte in data do
    i := i + 1;
    if Length(last14) < 14 then
        Add(last14, byte);
    else
        last14{[1..13]} := last14{[2..14]};
        last14[14] := byte;
        if Length(Set(last14)) = 14 then
            break;
        fi;
    fi;
od;

Print(last14);
Print(i);
