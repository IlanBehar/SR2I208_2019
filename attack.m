function [attacker] = attack(s)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
constA=100;
constB=5;
attacker = vehicle(s,'Position',[ constA constB 0],'Velocity',[ 0 0 0],'Yaw',0);

end

