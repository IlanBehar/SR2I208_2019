function [] = Draw(s, target)
%Draw : plot the scenario 

attacker=Attack(s, 2,target);

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


%% Chase plot
hPanel3 = uipanel(hFigure,'Units','Normalized','Position',[2/3 0 1/3 1],'Title','Chase Plot');
hAxes3 = axes('Parent',hPanel3);
chasePlot(target,'Parent', hAxes3);


%% Draw The all
while advance(s)
  plotTrack(attackTrackPlotter, attacker.Position-target.Position, attacker.Velocity-target.Velocity);
  rbs = roadBoundaries(target);
  plotLaneBoundary(targetLanePlotter, rbs);
  [position, yaw, length, width, originOffset, color] = targetOutlines(target);
  plotOutline(targetOutlinePlotter, position, yaw, length, width, 'OriginOffset', originOffset, 'Color', color);
end

end


