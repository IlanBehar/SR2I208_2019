function [] = draw(s, cars)
%Draw : plot the scenario 

hFigure = figure;
hFigure.Position(3) = 900;

hPanel1 = uipanel(hFigure,'Units','Normalized','Position',[0 0 1/2 1],'Title','Scenario Plot');
hPanel2 = uipanel(hFigure,'Units','Normalized','Position',[1/2 0 1/2 1],'Title','Bird Eyes Plot');

hAxes1 = axes('Parent',hPanel1);
hAxes2 = axes('Parent',hPanel2);

% assign a bird's-eye plot in second axes.
carBEP = birdsEyePlot('Parent',hAxes2);

targetLanePlotter = laneBoundaryPlotter(carBEP);
targetOutlinePlotter = outlinePlotter(carBEP);

plot(s,'RoadCenters','on','Parent',hAxes1);
s.SampleTime = 0.01;
s.StopTime = 2;

target=cars(1);

attackTrackPlotter = trackPlotter(carBEP,'MarkerEdgeColor','red','DisplayName','attack','VelocityScaling',.5);
targetTrackPlotter = trackPlotter(carBEP,'MarkerEdgeColor','blue','DisplayName','target','VelocityScaling',.5);
plotTrack(targetTrackPlotter, [0 0]);

while advance(s)
  t = targetPoses(target)
  plotTrack(attackTrackPlotter, t.Position, t.Velocity);
  rbs = roadBoundaries(target);
  plotLaneBoundary(targetLanePlotter, rbs);
  [position, yaw, length, width, originOffset, color] = targetOutlines(target);
  plotOutline(targetOutlinePlotter, position, yaw, length, width, 'OriginOffset', originOffset, 'Color', color);
end

end

