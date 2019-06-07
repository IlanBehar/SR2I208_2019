function [output] = AddVehicules(positions, line, speed, speedRange, s, roadLength, laneNumber)
%Add the vehicules in the scenario

i=1;
for pos=positions
    direction=1;
    currentLine=line(1:2,i*2-1:i*2);
    speedVar=randi(speedRange)-speedRange/2;
    mySpeed=speed+speedVar;
    if i>3
        direction=-1;
    end
    v = vehicle(s,'Position',[ pos currentLine(1) 0],'Velocity',[ 0 0 0],'Yaw',0);
    traj=[pos currentLine(1); direction*roadLength*2 currentLine(1)]; %*2 to allow more time for the simulation
    trajectory(v,traj(:,:), mySpeed);
    i=mod(i,laneNumber*2)+1;
end
output=[];
end

