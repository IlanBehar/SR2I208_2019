%%Initiate a highway

%Data to set
laneNumber=3;
roadLength=1000;%in meters
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
carsPerSecond=5;


s = drivingScenario;
roadCenters = [0 0; roadLength 0];
road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));
position=GetCarsPosition(carsPerSecond, laneNumber,speed ,roadLength);
line=GetLines(laneNumber, roadCenters);


i=1;
for pos=position
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

plot(s,'RoadCenters','on');
s.SampleTime = 0.01;
s.StopTime = 2;
laneWidth=3.6;
while advance(s)
  axis([roadLength*1/3 roadLength*2/3 -3*laneWidth 3*laneWidth]);
  pause(0.001);
end
