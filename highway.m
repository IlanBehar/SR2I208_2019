%%Initiate a highway

%Data to set
laneNumber=3;
roadLength=400;%in meters
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
carsPerSecond=5;
num_attack=12;
sybil=1;

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
attackerList=[];
for i=1:sybil
    attackerList =[attackerList vehicle(s,'Position',[ 0 0 0],'Velocity',[ speed 0 0],'Yaw',0)];
end

s.SampleTime = 0.05;
s.StopTime = 1;
Draw(s, target, attackerList, num_attack,line,roadLength,sybil);
