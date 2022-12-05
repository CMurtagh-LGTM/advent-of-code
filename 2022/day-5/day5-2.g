file_stream := InputTextFile("data.txt");

mode := true;

piles := [[], [], [], [], [], [], [], [], []];

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        if mode then
            if line = "" then
                mode := false;
                #piles:= List(piles, x->Reversed(x));
                Print(piles);
                continue;
            fi;
            
            crates := line{[2, 6..34]};

            if not crates = "123456789" then
                for i in [1..9] do
                    if (not crates[i] = ' ') then
                        Add(piles[i], crates[i]);
                    fi;
                od;
            fi;

        else
            commands := List(SplitString(line, " "));
            amount := Int(commands[2]);
            from := Int(commands[4]);
            to := Int(commands[6]);

            piles[to]{[(1+amount)..(Length(piles[to])+amount)]} := piles[to]{[1..Length(piles[to])]};
            piles[to]{[1..amount]} := piles[from]{[1..amount]};
            for i in [1..amount] do
                Remove(piles[from], 1);
            od;
        fi;
    fi;
od;

Print(piles);
for pile in piles do
    Print(pile[1]);
od;
