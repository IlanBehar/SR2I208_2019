%%Initiate a highway
laneWidth=2;
laneNumber=3;
roadLength=100;
speed=100/3.6;
s = drivingScenario;


roadCenters = [0 0; roadLength 0];

road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));

position=GetCarsPosition(5, laneNumber,speed ,roadLength);
y_pos=(-10:20/6:10);
i=1;
for pos=position
    y=y_pos(i);
    v = vehicle(s,'Position',[ pos y 0],'Velocity',[ 0 speed 0],'Yaw',0);
    i=mod(i,laneNumber*2)+1;
end

plot(s,'RoadCenters','on');

