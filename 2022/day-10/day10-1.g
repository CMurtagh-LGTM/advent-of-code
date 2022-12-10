file_stream := InputTextFile("data.txt");

x := 1;
cycle := 1;

strength_checks := [20, 60, 100, 140, 180, 220];
total_strengths := 0;

crt := ['#'];

mod_thing := function(a, m)
    if a <= m then
        return a;
    else
        if (a mod m) = 0 then
            return m;
        else
            return (a mod m);
        fi;
    fi;
end;

do_checks := function()
    if IsBound(strength_checks[1]) and cycle >= strength_checks[1] then
        total_strengths := total_strengths + strength_checks[1] * x;
        Remove(strength_checks, 1);
    fi;
    Print(mod_thing(cycle, 40), ", ", x, ", ", AbsoluteValue(x - mod_thing(cycle, 40)), "\n");
    if AbsoluteValue(x - mod_thing(cycle, 40)) < 2 then
        crt[cycle] := '#';
    else
        crt[cycle] := '.';
    fi;
end;

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        commands := SplitString(line, " ");
        if commands[1] = "noop" then
            do_checks();
            cycle := cycle + 1;
        elif commands[1] = "addx" then
            do_checks();
            cycle := cycle + 1;
            x := x + Int(commands[2]);
            do_checks();
            cycle := cycle + 1;
        else
            Erorr("invalid command ", commands[1]);
        fi;
    fi;
od;

Print(total_strengths,"\n");

for i in [1,41..201] do
    Print(crt{[i..i+39]},"\n");
od;
