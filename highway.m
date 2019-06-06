%%Initiate a highway
laneWidth=3.6;
laneNumber=3;
roadLength=1000;
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
s = drivingScenario;


roadCenters = [0 0; roadLength 0];

road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));

position=GetCarsPosition(5, laneNumber,speed ,roadLength);
i=1;

d = 3.6/2;
h = .45/2;
roadOffset = [ d 0; d 0]';
lane=[laneWidth 0 ; 0 laneWidth];        
line1 = roadCenters - roadOffset - 2*lane
line2 = roadCenters - roadOffset - lane;
line3 = roadCenters - roadOffset;
line4 = roadCenters + roadOffset;
line5 = roadCenters + roadOffset +lane;
line6 = roadCenters + roadOffset +2*lane;
line=[line1 line2 line3 line4 line5 line6];
% loop around the track four times

for pos=position
    currentLine=line(1:2,i*2-1:i*2);
    speedVar=randi(speedRange)-speedRange/2;
    mySpeed=speed+speedVar;
    v = vehicle(s,'Position',[ pos currentLine(1) 0],'Velocity',[ 0 0 0],'Yaw',0);
    i=mod(i,laneNumber*2)+1;
    traj=[pos currentLine(1); roadLength*2 currentLine(1)];
    trajectory(v,traj(:,:), mySpeed);
end

plot(s,'RoadCenters','on');
s.SampleTime = 0.02;
s.StopTime = 10;
while advance(s)
  axis([roadLength*1/3 roadLength*2/3 -3*laneWidth 3*laneWidth])
  pause(0.001)
end
