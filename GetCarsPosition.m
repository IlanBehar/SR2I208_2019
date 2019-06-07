function [output] = GetCarsPosition(carPerSecond, laneNumber, speed, roadLength)
%Set the number of car on the road
roadLength=roadLength*8/10
carsPerLanePerSecond=carPerSecond/laneNumber;
cars=[1:speed/carsPerLanePerSecond:roadLength];
output=cars;

