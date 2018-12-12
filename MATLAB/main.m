%script for processing obj files
%%
% Clean up before running anything:
%clc, clear all, close all
close all
%%
% Set the file name:
file = '../Scans/Alex, great scan, 9 dots, ideal lighting, no missing dots.obj';
%%
% Options for output (true/false):
timer = false; % Display the time for a function to run
plot = true; % Display point cloud plots
print = true; % Displays print messages
%%
% Import the vertices:
%vertices = importOBJ(file,timer);
%% 
%convert to point cloud and plot:
name = 'Original Colored Point Cloud';
ptCloud = verticesToPointCloud(vertices, false , name, timer);
%%
% Set desired color range:
colorRange_Dark = [0.05, 0.5; ... %Red   min. and max.
                   0.1,  0.3; ... %Green min. and max.
                   0.1,  0.3];    %Blue  min. and max.
colorRange_Blue = [  0, 0.6; ... %Red   min. and max.
                     0, 0.125; ... %Green min. and max.
                  0.05, 1];    %Blue  min. and max.
colorRange_Blue_low_light = [  0, .3; ... %Red   min. and max.
                               0, .06; ... %Green min. and max.
                               0.025, .5];    %Blue  min. and max.
colorRange_Blue_good_light = [  0, 0.14; ... %Red   min. and max.
                                0, 0.1; ... %Green min. and max.
                             0.08, 1];    %Blue  min. and max.
colorRange_HSV_blue = [0, 1; ... %Hue   min. and max.
                       0, 1; ... %Saturation min. and max.
                       0, 1];    %Value  min. and max.
% Filter out points that are not in the desured color range:
%vertices2 = filterColorRGB(vertices, colorRange_Blue_good_light, print, timer);
vertices2 = filterColorHSV(vertices, colorRange_HSV_blue, print, timer);

%%
%convert to point cloud and plot:
name = 'Filtered Point Cloud';
ptCloud = verticesToPointCloud(vertices2, plot, name, timer);
%{
%%
% Removes noise from point cloud and plot:
ptCloud = filterNoise (ptCloud, print, timer);
name = 'Filtered Point Cloud With Noise Removed';
plotPointCloud( ptCloud, name, timer);
%%
% Segment the point cloud into clusters:
minDistance = 1;
[labels,numClusters] = segmentPointCloud(ptCloud, minDistance, print, plot, timer);
%%
% Set the volume limitations (in cubic mm):
volumeLimit = [100, 1000];
% Filter out clusters of point clouds that are too big or too small:
ptCloudCell = filterPointCloudSize(ptCloud, labels, numClusters, volumeLimit, timer);
%%
% Plot the clusters in different colors
name = 'Clustered Point Clouds';
plotClusters(ptCloudCell, name, plot, timer);
%}