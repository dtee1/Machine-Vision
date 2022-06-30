
% Student name: David Talson
% Student number: 8419286
clc; clear; 

% Default Focal Length f = 5mm
f = 5;
%f = 1.5;
%f = 7;
numPoints = 1000;

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
pt = pointCloud(pointsObj,'Color',rgb);

figure (1);
pcshow(pt);
%title('3D Undulated Surface');
%xlabel('Xobj');
%ylabel('Zobj');
%zlabel('Yobj');

%% Part 2
%% Homogenous Transformation 

% Empty homogeneous matrix 
pointsSensor = zeros(size(pointsObj) + size(rgb));
[m j] = size(pointsObj);

%% Translation on z plane by 1000
% Iteratively calculate new camera coordinates
for i = 1:m
    pointsSensor(i,1) = pointsObj(i,1); 
    pointsSensor(i,2) = pointsObj(i,2) + 1000;
    pointsSensor(i,3) = pointsObj(i,3);
    pointsSensor(i,4) = rgb(i,1);
    pointsSensor(i,5) = rgb(i,2);
    pointsSensor(i,6) = rgb(i,3);
    hsvSensor(:,:,1) = 0.5*((pointsSensor(i,1)/1000)+1);
    hsvSensor(:,:,2) =  1;
    hsvSensor(:,:,3) = 0.5*((pointsSensor(i,3)/1000)+1);
end
rgbSensor = hsv2rgb(hsvSensor);
rgbSensor=reshape(rgbSensor,[], 3);

ptSensor = pointCloud(pointsSensor(:,[1,2,3]),'Color',pointsSensor(:,[4,5,6]));
%figure (2)
%pcshow(ptSensor);
%title('3D Undulated Surface as seen from Range Sensor');
%xlabel('Xcam');
%ylabel('Zcam');
%zlabel('Ycam');


%% Part 3 
%% Perspective Projection 

% Emtpy cartesian coordinates matrix
pointsCart = zeros(size(pointsObj));
pointDepth = zeros(1,height(pointsObj));

% Iteratively calculate new cartesian coordinates
for i = 1:m
    w = (pointsSensor(i,2) * (1/f)) + 1;
    pointsCart(i,1) = pointsSensor(i,1) / w; 
    pointsCart(i,2) = pointsSensor(i,2)/w;
    pointsCart(i,3) = pointsSensor(i,3)/w;
    %pointDepth(i) = pointsCart(i,2);
    pointDepth(i) = sqrt((pointsSensor(i,2)*pointsSensor(i,2) - pointsCart(i,2) * pointsCart(i,2) ) + (pointsSensor(i,3)*pointsSensor(i,3) - pointsCart(i,3)*pointsCart(i,3)));
end
pointDepth = reshape(pointDepth,[],1000);
pixel = zeros(480,640);
count = 1;
for i = 1:640
     for j = 1:480
         pixel(j,i) = pointDepth(j,i);
         count = count + 1;
     end 
     count = count + 480;
end


pointDepthN = reshape(pointDepth,[],1000);
max(pointDepthN,[],'all')
min(pointDepthN,[],'all')
pointDepthN = padarray(pointDepthN,[20 20],898,'both');
pointDepthN = ((pointDepthN - min(pointDepthN,[],'all'))./ (max(pointDepthN,[],'all') - min(pointDepthN,[],'all')))*255;
pixel = padarray(pixel,[5 5],min(pixel,[],'all') - 2,'both');
pixel = ((pixel - min(pixel,[],'all'))./ (max(pixel,[],'all') - min(pixel,[],'all')))*255;
figure(3)
%imshow(uint8(pointDepthN),[1 255]);
imshow(uint8(pixel),[1 255]);




