function [output] = GetCarsPosition(carPerSecond, laneNumber, speed, roadLength)
%Set the number of car on the road
delta=roadLength*3/10;
carsPerLanePerSecond=carPerSecond/laneNumber;
cars=[delta/2:speed/carsPerLanePerSecond:roadLength-delta];
output=cars;
