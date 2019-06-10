function [output] = AddVehicules(positions, line, speed, speedRange, s, roadLength, laneNumber)
%Add the vehicules in the scenario

i=1;
cars=[];
for pos=positions
    position=pos+roadLength*1/10;
    direction=1;
    currentLine=line(1:2,i*2-1:i*2);
    speedVar=randi(speedRange)-speedRange/2;
    mySpeed=speed+speedVar;
    if i>3
        direction=-1;
    end
    car = vehicle(s,'Position',[ pos currentLine(1) 0],'Velocity',[ 0 0 0],'Yaw',0);
    cars = [cars car];
    traj=[position currentLine(1); direction*roadLength currentLine(1)];
    trajectory(car,traj(:,:), mySpeed);
    i=mod(i,laneNumber*2)+1;
end
output=cars;
end
