function [position] = Attack(s,i, target, line, t, attacker)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
switch i
    case 1
        constA=300;
        constB=line(3);
        position=[constA constB 0];
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
end

