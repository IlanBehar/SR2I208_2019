function [] = Draw(s, target, attackerList, num_attack,line, roadLength, sibil)%sibil represente the number of attacker
%Draw : plot the scenario 
hFigure = figure;
hFigure.Position(3) = 900;
%% Scenario plot
hPanel1 = uipanel(hFigure,'Units','Normalized','Position',[0 0 1/3 1],'Title','Scenario Plot');
hAxes1 = axes('Parent',hPanel1);
xlim([-10 10]);
plot(s,'RoadCenters','on','Parent',hAxes1);


%% Track plot
hPanel2 = uipanel(hFigure,'Units','Normalized','Position',[1/3 0 1/3 1],'Title','Track Plot');
hAxes2 = axes('Parent',hPanel2);
carBEP = birdsEyePlot('Parent',hAxes2, 'Ylimits', [-20 20]);
targetLanePlotter = laneBoundaryPlotter(carBEP);
targetOutlinePlotter = outlinePlotter(carBEP);
listAttackTrackPlotter=[];
for i= 1:sibil
    listAttackTrackPlotter=[listAttackTrackPlotter trackPlotter(carBEP,'MarkerEdgeColor','red','DisplayName','attack','VelocityScaling',.5)];
end
targetTrackPlotter = trackPlotter(carBEP,'MarkerEdgeColor','blue','DisplayName','target','VelocityScaling',.5);
plotTrack(targetTrackPlotter, [0 0]);


%% Chase plot
hPanel3 = uipanel(hFigure,'Units','Normalized','Position',[2/3 0 1/3 1],'Title','Chase Plot');
hAxes3 = axes('Parent',hPanel3);
chasePlot(target,'Parent', hAxes3);


%% Draw The all
t=0;
while advance(s)
  for i= 1:sibil
    attacker=attackerList(i);
    attacker.Position=Attack(s, num_attack,target, line, t, attacker, roadLength);
    plotTrack(listAttackTrackPlotter(i), attacker.Position-target.Position, attacker.Velocity-target.Velocity);
  end
  t=1;
  rbs = roadBoundaries(target);
  plotLaneBoundary(targetLanePlotter, rbs);
  [position, yaw, length, width, originOffset, color] = targetOutlines(target);
  plotOutline(targetOutlinePlotter, position, yaw, length, width, 'OriginOffset', originOffset, 'Color', color);
end

end


