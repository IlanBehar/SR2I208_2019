function [position, a,b] = Attack(s,num_attack, target, line, t, attacker,roadLength,a,b)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
switch num_attack
    case 1
        if t==0
            constA=randi(2*roadLength);
            constB=20-randi(40);
            position=[constA constB 0];
        else
            position=attacker.Position;
        end
    case 2
        constA=50;
        constB=8;
        position=[constA+target.Position(1) constB+target.Position(2) 0];
    case 3
        A=40-randi(80);
        B=10-randi(20);
        position=[A+target.Position(1) B+target.Position(2) 0];
    case 4
        if t==0
            constA=40-randi(80);
            constB=25-randi(50);
            a=constA;
            b=constB;
            position=[constA+target.Position(1) constB+target.Position(2) 0];
        else
            position=[a+target.Position(1) b+target.Position(2) 0];
        end
    case 5
         if t==0
            constA=randi(roadLength);
            constB=line(2*randi(size(line)/2)+1);
            position=[constA constB 0];
        else
            constA=attacker.Position(1);
            constB=attacker.Position(2);
            position=[constA constB 0];
         end
    case 6 
        constA=50;
        constB=0;
        position=[constA+target.Position(1) constB+target.Position(2) 0];
    case 7
        if t==0
            constA=40-randi(80);
            constB=line(2*randi(size(line)/2)+1);
            a=constA;
            b=constB;
            position=[constA+target.Position(1) constB 0];
        else
            position=[a+target.Position(1) b 0];
        end
    case 9
        Vmax=30/3.6; %maximal variation
        if(attacker.Velocity(1)<Vmax)
            delta=1;
        else
            delta=(1-2*(randi(2)-1))*Vmax;
        end
        traj=[attacker.Position(1) attacker.Position(2); roadLength attacker.Position(2)];
        trajectory(attacker,traj(:,:), attacker.Velocity(1)+delta);
        position=attacker.Position;
    case 10
        jump=10; %distance the attacker will "jump"
        position=[jump+attacker.Position(1) attacker.Position(2) 0];
    case 11
        A=50;
        B=0;
        angleSnap=20;
        position=[A+target.Position(1) B+target.Position(2) 0];
        attacker.Yaw=attacker.Yaw+angleSnap;
    case 12
        A=1;
        B=1;
        position=[A+target.Position(1) B+target.Position(2) 0];
end

