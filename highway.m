%%Initiate a highway
laneWidth=3.6;
laneNumber=3;
roadLength=100;
speed=100/3.6;
s = drivingScenario;


roadCenters = [0 0; roadLength 0];

road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));

position=GetCarsPosition(5, laneNumber,speed ,roadLength);
i=1;

d = 3.6/2;
h = .45/2;
roadOffset = [ d 0; d 0]';
       
line1 = roadCenters - roadOffset - 2*laneWidth;
line2 = roadCenters - roadOffset - laneWidth
line3 = roadCenters - roadOffset
line4 = roadCenters + roadOffset;
line5 = roadCenters + roadOffset +laneWidth;
line6 = roadCenters + roadOffset +2*laneWidth;
line=[line1 line2 line3 line4 line5 line6];
% loop around the track four times

for pos=position
    currentLine=line(1:2,i*2-1:i*2);
    currentLine(1)
    v = vehicle(s,'Position',[ pos currentLine(1) 0],'Velocity',[ 0 speed 0],'Yaw',0);
    i=mod(i,laneNumber*2)+1;
    %trajectory(v,currentLine(:,:), 30);
end

plot(s,'RoadCenters','on');
%s.SampleTime = 0.02
%s.StopTime = 4;
%while advance(s)
%  pause(0.001)
%end
