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
positions=GetCarsPosition(carsPerSecond, laneNumber,speed ,roadLength);
line=GetLines(laneNumber, roadCenters);
AddVehicules(positions, line, speed, speedRange, s, roadLength, laneNumber);


plot(s,'RoadCenters','on');
s.SampleTime = 0.01;
s.StopTime = 2;
laneWidth=3.6;
while advance(s)
  axis([roadLength*1/3 roadLength*2/3 -3*laneWidth 3*laneWidth]);
  pause(0.001);
end
