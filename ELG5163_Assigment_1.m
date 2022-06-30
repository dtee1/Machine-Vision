% Step 1: Create 3D plot of surface
% Create ROBJ1
% Course: ELG 5163
% Student name: David Talson
% Student number: 
clc; clear; 

% Default Focal Length f = 5mm
f = 5;
%f = 1.5;
%f = 7;
numPoints = 2000;

% Create undulated surface
xAx =  linspace(-1000,1000,numPoints);
yAx = linspace(-1000,1000,numPoints);
[xCord,yCord] = meshgrid(xAx,yAx);
zCord = 100*sin(xCord./150);

% Undulated 3D surface matrix
pointsObj = [xCord(:),zCord(:),yCord(:)];

% Color pattern in HSV color space
hsv(:,:,1) = 0.5*((xCord./1000)+1);
hsv(:,:,2) =  1;
hsv(:,:,3) = 0.5*((-yCord./1000)+1);
rgb = hsv2rgb(hsv);
rgb=reshape(rgb,[], 3);
image(rgb);
pt = pointCloud(pointsObj,'Color',rgb);

figure (1);
pcshow(pt);
title('3D Undulated Surface');
xlabel('Xobj');
ylabel('Zobj');
zlabel('Yobj');

%% Part 2
%% Homogenous Transformation 

% Empty homogeneous matrix 
pointsCam = zeros(size(pointsObj));
[m j] = size(pointsObj);

%% Translation on z plane by 1000
% Iteratively calculate new camera coordinates
for i = 1:m
    pointsCam(i,1) = pointsObj(i,1); 
    pointsCam(i,2) = pointsObj(i,2) + 1000;
    pointsCam(i,3) = pointsObj(i,3);

end

%% Part 3 
%% Perspective Projection 

% Emtpy cartesian coordinates matrix
pointsCart = zeros(size(pointsObj));

% Iteratively calculate new cartesian coordinates
for i = 1:m
    w = (pointsCam(i,2) * (1/f)) + 1;
    pointsCart(i,1) = pointsCam(i,1) / w; 
    pointsCart(i,2) = 0;
    pointsCart(i,3) = pointsCam(i,3)/w;

end

pointsPixelx = ceil(pointsCart(:,1)./6.35*320 + 320);
pointsPixely = ceil(pointsCart(:,3)./6.35*240+ 240);

pointsPixel = [pointsPixelx,pointsPixely,zeros(size(pointsPixelx))];
pt2 = pointCloud(pointsPixel,'Color',rgb);

figure (2);
pcshow(pt2);
title('IM Rcam1 RGB f5');
% title('IM Rcam1 RGB f3');
% title('IM Rcam1 RGB f7');
xlabel('Xpixel');
ylabel('Ypixel');

hsvIM = rgb2hsv(rgb);
pt2 = pointCloud(pointsPixel,'Color',hsvIM);

figure (3);
pcshow(pt2);
title('IM Rcam1 HSV f5');
% title('IM Rcam1 HSV f5');
% title('IM Rcam1 HSV f7');
xlabel('Xpixel');
ylabel('Ypixel');

% Influence of camera viewpoint on image formation 
% Camera at left position
% % Empty homogeneous matrix 
pointsCamLeft = zeros(size(pointsObj));
[m j] = size(pointsObj);

% Iteratively calculate new camera coordinates
for i = 1:m
    pointsCamLeft(i,1) = (0.866*pointsObj(i,1)) + (-0.5)*pointsObj(i,2) + 400; 
    pointsCamLeft(i,2) = (0.5*pointsObj(i,1)) + (0.866*pointsObj(i,2)) + (-600);
    pointsCamLeft(i,3) = pointsObj(i,3);

end

% Emtpy cartesian coordinates matrix
pointsCartLeft = zeros(size(pointsObj));

% Iteratively calculate new cartesian coordinates
for i = 1:m
    w = (pointsCamLeft(i,2) * (1/f)) + 1;
    pointsCartLeft(i,1) = pointsCamLeft(i,1) / w; 
    pointsCartLeft(i,2) = 0;
    pointsCartLeft(i,3) = pointsCamLeft(i,3)/w;

end

pointsPixelxLeft = ceil((pointsCartLeft(:,1)./6.35)*320 + 320);
pointsPixelyLeft = ceil((pointsCartLeft(:,3)./6.35)*240+ 240);

pointsPixelxLeft(pointsPixelxLeft < 0) = NaN;
pointsPixelxLeft(pointsPixelxLeft > 640) = NaN;

pointsPixelyLeft(pointsPixelyLeft < 0) = NaN;
pointsPixelyLeft(pointsPixelyLeft > 480) = NaN;

pointsPixelLeft = [pointsPixelxLeft,pointsPixelyLeft,zeros(size(pointsPixelxLeft))];
pt2Left = pointCloud(pointsPixelLeft,'Color',rgb);

figure (4);

pcshow(pt2Left);
title('IM Rcam2 RGB f5');
% title('IM Rcam1 RGB f3');
% title('IM Rcam1 RGB f7');
xlabel('Xpixel');
ylabel('Ypixel');

hsvIM = rgb2hsv(rgb);
pt3Left = pointCloud(pointsPixelLeft,'Color',hsvIM);

figure (5);
pcshow(pt3Left);
title('IM Rcam1 HSV f5');
xlabel('Xpixel');
ylabel('Zpixel');
zlabel('Ycam');

% Influence of camera viewpoint on image formation 
% Camera at Right position
% % Empty homogeneous matrix 
pointsCamRight = zeros(size(pointsObj));
[m j] = size(pointsObj);

% Iteratively calculate new camera coordinates
for i = 1:m
    pointsCamRight(i,1) = (0.7071*pointsObj(i,1)) + (0.7071)*pointsObj(i,2) + (-1200); 
    pointsCamRight(i,2) = (-0.7071*pointsObj(i,1)) + (0.7071*pointsObj(i,2));
    pointsCamRight(i,3) = pointsObj(i,3);

end

% Emtpy cartesian coordinates matrix
pointsCartRight = zeros(size(pointsObj));

% Iteratively calculate new cartesian coordinates
for i = 1:m
    w = (pointsCamRight(i,2) * (1/f)) + 1;
    pointsCartRight(i,1) = pointsCamRight(i,1) / w; 
    pointsCartRight(i,2) = 0;
    pointsCartRight(i,3) = pointsCamRight(i,3)/w;

end

pointsPixelxRight = ceil((pointsCartRight(:,1)./6.35*320) + 320);
pointsPixelyRight = ceil((pointsCartRight(:,3)./6.35*240) + 240);

pointsPixelxRight(pointsPixelxRight < -620) = NaN;
pointsPixelxRight(pointsPixelxRight > 620) = NaN;

pointsPixelyRight(pointsPixelyRight < -640) = NaN;
pointsPixelyRight(pointsPixelyRight > 640) = NaN;

pointsPixelRight = [pointsPixelxRight,pointsPixelyRight,zeros(size(pointsPixelxRight))];
pt2Right = pointCloud(pointsPixelRight);

figure (6);
pcshow(pt2Right);
title('IM Rcam2 RGB f5');
% title('IM Rcam1 RGB f3');
% title('IM Rcam1 RGB f7');
xlabel('Xcam');
ylabel('Zcam');
zlabel('Ycam');

hsvIM = rgb2hsv(rgb);
pt3Right = pointCloud(pointsPixelRight,'Color',hsvIM);

figure (7);
pcshow(pt3Right);
title('IM Rcam1 HSV f5');
xlabel('Xcam');
ylabel('Zcam');
zlabel('Ycam');
