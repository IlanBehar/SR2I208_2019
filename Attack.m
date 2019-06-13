function [attacker] = Attack(s,i, target)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
constA=100;
constB=5;

switch i
    case 1
        attacker = vehicle(s,'Position',[ constA constB 0],'Velocity',[ 0 0 0],'Yaw',0);
    case 2
        attacker= vehicle(s,'Position',[ constA+target.Position(1) constB+target.Position(2) 0],'Velocity',[ 0 0 0],'Yaw',0);
  
end

