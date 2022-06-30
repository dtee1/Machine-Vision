  %% Motion Detection based on absolute temporal diffeentiation and thresholding 


% Course: ELG 5163
% Student name: David Talson
% Student number: 8419286
clc; clear; clear all;

% Effect of noise and image filtering 
t1 = imread('ImageSequence/image001.jpg');
t2 = imread('ImageSequence/image002.jpg');

for a = 1:10
    b = a/10;
    fol = 'Result_'+string(b);
    mkdir([fol]);
    for i = 1:149
        j = num2str(i,'%03.f');
        k = num2str(i+1,'%03.f');
        motion = imabsdiff(imread('ImageSequence/image'+string(j)+'.jpg'),imread('ImageSequence/image'+string(k)+'.jpg'));
        t  = imbinarize(motion,b);
        imwrite(t,fol+'/motion'+string(i)+'.jpg');
    end
end
imshow(motion);

%% Part 2 
background = imread('ImageSequence/image001.jpg');
for c=1:10
    d = c/10;
    alpha = d;
    for a = 1:10
        b = a/10;
        threshold = b;
        fol = 'Result_Adaptive_alpha'+string(alpha)+'_threshold_'+string(threshold);
        mkdir([fol]);
        for i = 2:149
            j = num2str(i-1,'%03.f');
            k = num2str(i,'%03.f');
            image = imread('ImageSequence/image'+string(k)+'.jpg');
            motion_b = abs( image - background );
            image_diff = imabsdiff(image,background);
            t  = imbinarize(image_diff,threshold);
            imwrite(t,fol+'/motion_adaptive'+string(i)+'.jpg');
            if motion_b(motion_b >= threshold)
                background = (alpha*background) + ((1-alpha)*image);
            else 
                background = image;
            end
        end
        %zip('Result_Adaptive_alpha'+string(alpha)+'_threshold_'+string(threshold),'Result_Adaptive_alpha'+string(alpha)+'_threshold_'+string(threshold));
    end
end

