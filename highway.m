%%Initiate a highway

%Data to set
laneNumber=3;
roadLength=400;%in meters
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
carsPerSecond=5;
num_attack=3;

s = drivingScenario;
roadCenters = [0 0; roadLength 0];
road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));
positions=GetCarsPosition(carsPerSecond, laneNumber,speed ,roadLength);
line=GetLines(laneNumber, roadCenters);
cars=AddVehicules(positions, line, speed, speedRange, s, roadLength, laneNumber);


%index = index of the target car
A = int16(numel(cars));
B = int16(2);
index = idivide(A,B);
target=cars(index);
attacker = vehicle(s,'Position',[ 0 0 0],'Velocity',[ speed 0 0],'Yaw',0);

s.SampleTime = 0.01;
s.StopTime = 4;
Draw(s, target, attacker, num_attack,line);
