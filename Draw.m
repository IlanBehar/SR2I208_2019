function [] = Draw(s, target)
%Draw : plot the scenario 

attacker=attack(s);

hFigure = figure;
hFigure.Position(3) = 900;
%% Scenario plot
hPanel1 = uipanel(hFigure,'Units','Normalized','Position',[0 0 1/3 1],'Title','Scenario Plot');
hAxes1 = axes('Parent',hPanel1);
plot(s,'RoadCenters','on','Parent',hAxes1);


%% Track plot
hPanel2 = uipanel(hFigure,'Units','Normalized','Position',[1/3 0 1/3 1],'Title','Track Plot');
hAxes2 = axes('Parent',hPanel2);
carBEP = birdsEyePlot('Parent',hAxes2, 'Ylimits', [-20 20]);
targetLanePlotter = laneBoundaryPlotter(carBEP);
targetOutlinePlotter = outlinePlotter(carBEP);
attackTrackPlotter = trackPlotter(carBEP,'MarkerEdgeColor','red','DisplayName','attack','VelocityScaling',.5);
targetTrackPlotter = trackPlotter(carBEP,'MarkerEdgeColor','blue','DisplayName','target','VelocityScaling',.5);
plotTrack(targetTrackPlotter, [0 0]);


%% Sensor plot
hPanel3 = uipanel(hFigure,'Units','Normalized','Position',[2/3 0 1/3 1],'Title','Sensor Plot');
hAxes3 = axes('Parent',hPanel3);
sensorBEP = birdsEyePlot('Parent',hAxes3,'Xlimits', [0 90], 'Ylimits', [-35 35]);
cap(1) = coverageAreaPlotter(sensorBEP,'FaceColor','blue','EdgeColor','blue');
%cap(2) = coverageAreaPlotter(sensorBEP,'FaceColor','red','EdgeColor','red');
%cap(3) = coverageAreaPlotter(sensorBEP,'FaceColor','red','EdgeColor','red');

radarSensor = radarDetectionGenerator(...
    'SensorIndex', 1, ...
    'SensorLocation', [target.Wheelbase+target.FrontOverhang 0], ...
    'Height', 0.2, ...
    'FieldOfView', [20 5], ...
    'MaxRange', 150, ...
    'ActorProfiles', actorProfiles(s));
% Use the sensor configuration to plot the sensor coverage areas. Vision
% sensor uses the shaded blue coverage area and radar modes are shaded in
% red.
%for i = 1:3
%    plotCoverageArea(cap(i), [sensorParams(i).X, sensorParams(i).Y],...
%       sensorParams(i).Range, sensorParams(i).YawAngle, sensorParams(i).FoV);
%end
plotCoverageArea(cap(1), radarSensor.SensorLocation, radarSensor.MaxRange, 0, radarSensor.FieldOfView(1))

%% Draw The all
while advance(s)
  plotTrack(attackTrackPlotter, attacker.Position-target.Position, attacker.Velocity-target.Velocity);
  rbs = roadBoundaries(target);
  plotLaneBoundary(targetLanePlotter, rbs);
  [position, yaw, length, width, originOffset, color] = targetOutlines(target);
  plotOutline(targetOutlinePlotter, position, yaw, length, width, 'OriginOffset', originOffset, 'Color', color);
end

end


