file_stream := InputTextFile("data.txt");

last4 := [];
i := 0;

data := ReadAll(file_stream);

for byte in data do
    i := i + 1;
    if Length(last4) < 4 then
        Add(last4, byte);
    else
        last4{[1..3]} := last4{[2..4]};
        last4[4] := byte;
        if Length(Set(last4)) = 4 then
            break;
        fi;
    fi;
od;

Print(last4);
Print(i);
