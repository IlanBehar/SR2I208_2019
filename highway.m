%%Initiate a highway
laneWidth=2;
laneNumber=3;
roadLength=10000;

s = drivingScenario;


roadCenters = [0 0; roadLength 0];

road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));

plot(s,'RoadCenters','on');
