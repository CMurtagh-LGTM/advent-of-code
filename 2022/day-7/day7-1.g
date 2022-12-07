file_stream := InputTextFile("data.txt");

hierarchy := rec(size:=0);
current := hierarchy;
path := [hierarchy];

while(not IsEndOfStream(file_stream)) do
    line := Chomp(ReadLine(file_stream));
    if line = fail then
        break;
    else
        if StartsWith(line, "$ cd") then
            folder := SplitString(line, " ")[3];
            if folder = "/" then
                current := hierarchy;
                path := [hierarchy];
            elif folder = ".." then
                if not path = [hierarchy] then
                    Remove(path);
                    current := Last(path);
                fi;
            else
                current := current.(folder);
                Add(path, current);
            fi;
        elif StartsWith(line, "$ ls") then
        else
            info := SplitString(line, " ");
            if not IsBound(current.(info[2])) then
                if info[1] = "dir" then
                    current.(info[2]) := rec(size:=0);
                else
                    current.(info[2]) := Int(info[1]);
                    for a in path do
                        a.size := a.size + Int(info[1]);
                    od;
                fi;
            fi;
        fi;
    fi;
od;

total := function(h)
    local name, s, t;
    if h.size < 100000 then
        s := h.size;
    else
        s := 0;
    fi;
    for name in  RecNames(h) do
        if IsRecord(h.(name)) then
            s := s + total(h.(name));
        fi;
    od;
    return s;
end;

find_large_enough_files := function(h, req, l)
    local name;
    if h.size > req then
        Add(l, h);
    fi;
    for name in  RecNames(h) do
        if IsRecord(h.(name)) then
            find_large_enough_files(h.(name), req, l);
        fi;
    od;
end;

delete_size := function(h, req)
    local l;
    l := [];
    find_large_enough_files(h, req, l);
    Sort(l);
    return l[1].size;
end;

tree := function(h, indent)
    local name, i;
    for name in RecNames(h) do
        if not name = "size" then
            if IsInt(h.(name)) then
                for i in [1..indent] do
                    Print("|   ");
                od;
                Print(name, " ", h.(name),"\n");
            fi;
        fi;
    od;
    for name in RecNames(h) do
        if not name = "size" then
            if IsRecord(h.(name)) then
                for i in [1..indent] do
                    Print("|   ");
                od;
                Print(name, " ", h.(name).size,"\n");
                tree(h.(name), indent + 1);
            fi;
        fi;
    od;
end;

Print(total(hierarchy), "\n");
#tree(hierarchy, 0);

Print(delete_size(hierarchy,  30000000 - (70000000 - hierarchy.size)));
