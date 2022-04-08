% Course: ELG 5163
% Student name: David Talson 
clc; clear; clear all;

% Effect of noise and image filtering 
olympicsG = rgb2gray(imread('olympics_RGB.jpg'));
winterG = rgb2gray(imread('winterlude_RGB.jpg'));

imwrite(olympicsG,'olympics_BW.jpg');
imwrite(winterG,'winterlude_BW.jpg');

% Add gaussian noise with a variance of 0.01 to image
olyNoiseG = imnoise(imread('olympics_BW.jpg'),'gaussian');
winNoiseG = imnoise(imread('winterlude_BW.jpg'),'gaussian');

imwrite(olyNoiseG,'olympics_Noise_G.jpg');
imwrite(winNoiseG,'winterlude_Noise_G.jpg');

% Add Salt & pepper noise with a density of 0.03
olyNoiseS = imnoise(imread('olympics_BW.jpg'),'salt & pepper', 0.03);
winNoiseS = imnoise(imread('winterlude_BW.jpg'),'salt & pepper', 0.03);

imwrite(olyNoiseS,'olympics_Noise_S.jpg');
imwrite(winNoiseS,'winterlude_Noise_S.jpg');


% Mask filter definition
filter3 = ones(3,3)/9;
filter7 = ones(7,7)/49;
h = fspecial('gaussian',[7 7]);

img12G = imfilter(olyNoiseG,filter3);
img22G = imfilter(winNoiseG,filter3);

imwrite(img12G,'olympics_Gaussian_Noise_Mean_3.jpg');
imwrite(img22G,'winterlude_Gaussian_Noise_Mean_3.jpg');

img12S = imfilter(olyNoiseS,filter3);
img22S = imfilter(winNoiseS,filter3);

imwrite(img12S,'olympics_Salt&Pepper_Noise_Mean_3.jpg');
imwrite(img22S,'winterlude_Salt&Pepper_Noise_Mean_3.jpg');

%%

img12G = imfilter(olyNoiseG,filter7);
img22G = imfilter(winNoiseG,filter7);

imwrite(img12G,'olympics_Gaussian_Noise_Mean_7.jpg');
imwrite(img22G,'winterlude_Gaussian_Noise_Mean_7.jpg');


img12S = imfilter(olyNoiseS,filter7);
img22S = imfilter(winNoiseS,filter7);

imwrite(img12S,'olympics_Salt&Pepper_Noise_Mean_7.jpg');
imwrite(img22S,'winterlude_Salt&Pepper_Noise_Mean_7.jpg');

%%
img12G = imfilter(olyNoiseG,h);
img22G = imfilter(winNoiseG,h);

imwrite(img12G,'olympics_Gaussian_Noise_Gaussian_7.jpg');
imwrite(img22G,'winterlude_Gaussian_Noise_Gaussian_7.jpg');

img12S = imfilter(olyNoiseS,h);
img22S = imfilter(winNoiseS,h);

imwrite(img12S,'olympics_Salt&Pepper_Noise_Gaussian_7.jpg');
imwrite(img22S,'winterlude_Salt&Pepper_Noise_Gaussian_7.jpg');

%%
img12G = medfilt2(olyNoiseG);
img22G = medfilt2(winNoiseG);

imwrite(img12G,'olympics_Gaussian_Noise_Median_3.jpg');
imwrite(img22G,'winterlude_Gaussian_Noise_Median_3.jpg');


img12S = medfilt2(olyNoiseS);
img22S = medfilt2(winNoiseS);

imwrite(img12S,'olympics_Salt&Pepper_Noise_Median_3.jpg');
imwrite(img22S,'winterlude_Salt&Pepper_Noise_Median_3.jpg');


%% Part 2
%% Effect of noise and image complexity on edge detection 

% Sobel
imgSobelO = edge(olympicsG,'sobel');
imwrite(imgSobelO,'olympics_BW_Sobel.jpg');

imgSobelOG = edge(olyNoiseG,'sobel');
imwrite(imgSobelOG,'olympics_Gaussian_Sobel.jpg');

imgSobelOS = edge(olyNoiseS,'sobel');
imwrite(imgSobelOS,'olympics_Salt&Pepper_Sobel.jpg');

imgSobelG = edge(imread('olympics_Gaussian_Noise_Gaussian_7.jpg'),'sobel');
imwrite(imgSobelG,'olympics_Gaussian_Filtered_Sobel.jpg');

imgSobelS = edge(imread('olympics_Salt&Pepper_Noise_Median_3.jpg'),'sobel');
imwrite(imgSobelS,'olympics_Median_Filtered_Sobel.jpg');

%% Prewitt 
imgPrewittO = edge(olympicsG,'prewitt');
imwrite(imgPrewittO,'olympics_BW_Prewitt.jpg');

imgPrewittOG = edge(olyNoiseG,'prewitt');
imwrite(imgPrewittOG,'olympics_Gaussian_Prewitt.jpg');

imgPrewittOS = edge(olyNoiseS,'prewitt');
imwrite(imgPrewittOS,'olympics_Salt&Pepper_Prewitt.jpg');

imgPrewittG = edge(imread('olympics_Gaussian_Noise_Gaussian_7.jpg'),'prewitt');
imwrite(imgPrewittG,'olympics_Gaussian_Filtered_Prewitt.jpg');

imgPrewittS = edge(imread('olympics_Salt&Pepper_Noise_Median_3.jpg'),'prewitt');
imwrite(imgPrewittS,'olympics_Median_Filtered_Prewitt.jpg');


%% Log 
imgLogO = edge(olympicsG,'log');
imwrite(imgLogO,'olympics_BW_Log.jpg');

imgLogOG = edge(olyNoiseG,'log');
imwrite(imgLogOG,'olympics_Gaussian_Log.jpg');

imgLogOS = edge(olyNoiseS,'log');
imwrite(imgLogOS,'olympics_Salt&Pepper_Log.jpg');

imgLogG = edge(imread('olympics_Gaussian_Noise_Gaussian_7.jpg'),'log');
imwrite(imgLogG,'olympics_Gaussian_Filtered_Log.jpg');

imgLogS = edge(imread('olympics_Salt&Pepper_Noise_Median_3.jpg'),'log');
imwrite(imgLogS,'olympics_Median_Filtered_Log.jpg');

%% Canny
imgCannyO = edge(olympicsG,'canny');
imwrite(imgCannyO,'olympics_BW_Canny.jpg');

imgCannyOG = edge(olyNoiseG,'canny',0.3);
imwrite(imgCannyOG,'olympics_Gaussian_Canny.jpg');

imgCannyOS = edge(olyNoiseS,'canny');
imwrite(imgCannyOS,'olympics_Salt&Pepper_Canny.jpg');

imgCannyG = edge(imread('olympics_Gaussian_Noise_Gaussian_7.jpg'),'canny');
imwrite(imgCannyG,'olympics_Gaussian_Filtered_Canny.jpg');

imgCannyS = edge(imread('olympics_Salt&Pepper_Noise_Median_3.jpg'),'canny');
imwrite(imgCannyS,'olympics_Median_Filtered_Canny.jpg');


%%%%%%
%%%%%%
% Sobel
imgSobelO = edge(winterG,'sobel');
imwrite(imgSobelO,'winterlude_BW_Sobel.jpg');

imgSobelOG = edge(winNoiseG,'sobel');
imwrite(imgSobelOG,'winterlude_Gaussian_Sobel.jpg');

imgSobelOS = edge(winNoiseS,'sobel');
imwrite(imgSobelOS,'winterlude_Salt&Pepper_Sobel.jpg');

imgSobelG = edge(imread('winterlude_Gaussian_Noise_Gaussian_7.jpg'),'sobel');
imwrite(imgSobelG,'winterlude_Gaussian_Filtered_Sobel.jpg');

imgSobelS = edge(imread('winterlude_Salt&Pepper_Noise_Median_3.jpg'),'sobel');
imwrite(imgSobelS,'winterlude_Median_Filtered_Sobel.jpg');

%% Prewitt 
imgPrewittO = edge(winterG,'prewitt');
imwrite(imgPrewittO,'winterlude_BW_Prewitt.jpg');

imgPrewittOG = edge(winNoiseG,'prewitt');
imwrite(imgPrewittOG,'winterlude_Gaussian_Prewitt.jpg');

imgPrewittOS = edge(winNoiseS,'prewitt');
imwrite(imgPrewittOS,'winterlude_Salt&Pepper_Prewitt.jpg');

imgPrewittG = edge(imread('winterlude_Gaussian_Noise_Gaussian_7.jpg'),'prewitt');
imwrite(imgPrewittG,'winterlude_Gaussian_Filtered_Prewitt.jpg');

imgPrewittS = edge(imread('winterlude_Salt&Pepper_Noise_Median_3.jpg'),'prewitt');
imwrite(imgPrewittS,'winterlude_Median_Filtered_Prewitt.jpg');

%% Log 
imgLogO = edge(winterG,'log');
imwrite(imgLogO,'winterlude_BW_Log.jpg');

imgLogOG = edge(winNoiseG,'canny');
imwrite(imgLogOG,'winterlude_Gaussian_Log.jpg');

imgLogOS = edge(winNoiseS,'log');
imwrite(imgLogOS,'winterlude_Salt&Pepper_Log.jpg');

imgLogG = edge(imread('winterlude_Gaussian_Noise_Gaussian_7.jpg'),'log');
imwrite(imgLogG,'winterlude_Gaussian_Filtered_Log.jpg');

imgLogS = edge(imread('winterlude_Salt&Pepper_Noise_Median_3.jpg'),'log');
imwrite(imgLogS,'winterlude_Median_Filtered_Log.jpg');

%% Canny
imgCannyO = edge(winterG,'canny');
imwrite(imgCannyO,'winterlude_BW_canny.jpg');

imgCannyOG = edge(winNoiseG,'canny');
imwrite(imgCannyOG,'winterlude_Gaussian_Canny.jpg');

imgCannyOS = edge(winNoiseS,'canny');
imwrite(imgCannyOS,'winterlude_Salt&Pepper_Canny.jpg');

imgCannyG = edge(imread('winterlude_Gaussian_Noise_Gaussian_7.jpg'),'canny');
imwrite(imgCannyG,'winterlude_Gaussian_Filtered_Canny.jpg');

imgCannyS = edge(imread('winterlude_Salt&Pepper_Noise_Median_3.jpg'),'canny');
imwrite(imgCannyS,'winterlude_Median_Filtered_Canny.jpg');


%% Study of Image Segmentation 

for i = 1:9
    j = i/10;
    imwrite(imbinarize(olympicsG,j),'olympics_BW_'+string(j)+'.jpg');
    imwrite(imbinarize(winterG,j),'winterlude_BW_'+string(j)+'.jpg');

    imwrite(imbinarize(imread('olympics_RGB.jpg'),j),'olympics_RGB_'+string(j)+'.jpg');
    imwrite(imbinarize(imread('winterlude_RGB.jpg'),j),'winterlude_RGB_'+string(j)+'.jpg');
end

imwrite(imbinarize(olympicsG),'olympics_BW_Adaptive.jpg');
imwrite(imbinarize(winterG),'winterlude_BW_Adaptive.jpg');

imwrite(imbinarize(imread('olympics_RGB.jpg')),'olympics_RGB_Adaptive.jpg');
imwrite(imbinarize(imread('winterlude_RGB.jpg')),'winterlude_RGB_Adaptive.jpg');
