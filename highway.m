%%Initiate a highway

%Data to set
laneNumber=3;
roadLength=400;%in meters
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
carsPerSecond=5;


s = drivingScenario;
roadCenters = [0 0; roadLength 0];
road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));
positions=GetCarsPosition(carsPerSecond, laneNumber,speed ,roadLength);
line=GetLines(laneNumber, roadCenters);
cars=AddVehicules(positions, line, speed, speedRange, s, roadLength, laneNumber);


target=cars(1);
attack=cars(2);

draw(s, target, attack);