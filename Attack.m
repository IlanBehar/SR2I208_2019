function [position] = Attack(s,i, target, line, t, attacker,roadLength)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
switch i
    case 1
        if t==0
            constA=randi(roadLength);
            constB=10-randi(20);
            position=[constA constB 0];
        else
            constA=attacker.Position(1);
            constB=attacker.Position(2);
            position=[constA constB 0];
        end
    case 2
        constA=50;
        constB=0;
        position=[constA+target.Position(1) constB+target.Position(2) 0];
    case 3
        A=40-randi(80);
        B=10-randi(20);
        position=[A+target.Position(1) B+target.Position(2) 0];
    case 4
        if t==0
            constA=40-randi(80);
            constB=10-randi(20);
            position=[constA+target.Position(1) constB+target.Position(2) 0];
        else
            constA=attacker.Position(1);
            constB=attacker.Position(2);
            position=[constA constB 0];
        end
    case 5
         if t==0
            constA=randi(roadLength);
            constB=line(randi(size(line)));
            position=[constA constB 0];
        else
            constA=attacker.Position(1);
            constB=attacker.Position(2);
            position=[constA constB 0];
        end
end

