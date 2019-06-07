%%Initiate a highway

%Data to set
laneNumber=3;
roadLength=40;%in meters
speed=100/3.6;%km/h -> m/s
speedRange=floor(60/3.6); %speed can go from speed-speedRange/2 to speed+speedRange/2
carsPerSecond=5;


laneWidth=3.6;
s = drivingScenario;
roadCenters = [0 0; roadLength 0];
road(s, roadCenters, 'lanes', lanespec([laneNumber laneNumber]));
position=GetCarsPosition(carsPerSecond, laneNumber,speed ,roadLength);

d = laneWidth/2;
roadOffset = [ d 0; d 0]';
lane=[laneWidth laneWidth ; 0 0];  
line=[];

for i=-laneNumber: laneNumber-1
    if i>=0
        currentLine=roadCenters + roadOffset + i*lane;
    else
        currentLine=roadCenters - roadOffset + (i+1)*lane;
    end
    line=[line currentLine];
end


i=1;
cars=[];
for pos=position
    direction=1;
    currentLine=line(1:2,i*2-1:i*2);
    speedVar=randi(speedRange)-speedRange/2;
    mySpeed=speed+speedVar;
    if i>3
        direction=-1;
    end
    car = vehicle(s,'Position',[ pos currentLine(1) 0],'Velocity',[ 0 0 0],'Yaw',0);
    cars = [cars car];
    traj=[pos currentLine(1); direction*roadLength*2 currentLine(1)]; %*2 to allow more time for the simulation
    trajectory(car,traj(:,:), mySpeed);
    i=mod(i,laneNumber*2)+1;
end

hFigure = figure;
hFigure.Position(3) = 900;

hPanel1 = uipanel(hFigure,'Units','Normalized','Position',[0 0 1/2 1],'Title','Scenario Plot');
hPanel2 = uipanel(hFigure,'Units','Normalized','Position',[1/2 0 1/2 1],'Title','Bird Eyes Plot');

hAxes1 = axes('Parent',hPanel1);
hAxes2 = axes('Parent',hPanel2);

otherCarsTrackPlotter = [];
% assign a bird's-eye plot in third axes.
CarBEP = birdsEyePlot('Parent',hAxes2);
for car=cars
    otherCarsTrackPlotter = [otherCarsTrackPlotter trackPlotter(CarBEP,'MarkerEdgeColor','blue','DisplayName','target','VelocityScaling',.5)];
end
egoLanePlotter = laneBoundaryPlotter(CarBEP);
%for otherCarTrackPlotter=otherCarsTrackPlotter
%    plotTrack(otherCarTrackPlotter, [0 0]);
%end
plotTrack(otherCarsTrackPlotter(1), [0 0]);
egoOutlinePlotter = outlinePlotter(CarBEP);

plot(s,'RoadCenters','on','Parent',hAxes1);
s.SampleTime = 0.01;
s.StopTime = 2;

while advance(s)
  
  t = targetPoses(cars(1));
  for i = 2:size(cars)
     plotTrack(otherCarsTrackPlotter(i), t.Position, t.Velocity);
  end 
  rbs = roadBoundaries(cars(1));
  plotLaneBoundary(egoLanePlotter, rbs);
  [position, yaw, length, width, originOffset, color] = targetOutlines(cars(1));
  plotOutline(egoOutlinePlotter, position, yaw, length, width, 'OriginOffset', originOffset, 'Color', color);
end
