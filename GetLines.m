function [output] = GetLines(laneNumber, roadCenters)
%return the lane used by the cars
laneWidth=3.6;
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
output=line;

end

