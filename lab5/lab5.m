%% R1.b)
clear all; close all
load("sar_image.mat");
figure; colormap hsv %apply a different color mapping to better distinguish ice from water
imagesc(I); truesize 

%% R1.c)
clear all; close all
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]); %big lower right chunk of ice
water = imcrop(I, [1 1 629 1234]); %big upper left chunk of water
%compute the different Maximum Likelihood Estimators for both ice and water
p_ice_exp = mle(ice(:), 'distribution', 'Exponential');
p_ice_ray = mle(ice(:), 'distribution', 'Rayleigh');
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_exp = mle(water(:), 'distribution', 'Exponential');
p_water_ray = mle(water(:), 'distribution', 'Rayleigh');
p_water_nor = mle(water(:), 'distribution', 'Normal');

%% R1.d)
clear all; close all
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_exp = mle(ice(:), 'distribution', 'Exponential');
p_ice_ray = mle(ice(:), 'distribution', 'Rayleigh');
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_exp = mle(water(:), 'distribution', 'Exponential');
p_water_ray = mle(water(:), 'distribution', 'Rayleigh');
p_water_nor = mle(water(:), 'distribution', 'Normal');

figure('Name', 'Ice'); histogram(ice(:), 'Normalization', 'pdf', 'EdgeAlpha', 0) %normalized histogram of the ice values
ice_exp = exppdf(1:max(ice(:)), p_ice_exp); %compute the pdf with exponential distribution
hold on; plot(1:max(ice(:)), ice_exp, 'LineWidth', 2.5)
ice_ray = raylpdf(1:max(ice(:)), p_ice_ray); %compute the pdf with Rayleigh distribution
hold on; plot(1:max(ice(:)), ice_ray, 'LineWidth', 2.5)
ice_nor = normpdf(1:max(ice(:)), p_ice_nor(1), p_ice_nor(2)); %compute the pdf with normal distribution
hold on; plot(1:max(ice(:)), ice_nor, 'LineWidth', 2.5)

figure('Name', 'Water'); histogram(water(:), 'Normalization', 'pdf', 'EdgeAlpha', 0) %normalized histogram of the water values
water_exp = exppdf(1:max(water(:)), p_water_exp); %compute the pdf with exponential distribution
hold on; plot(1:max(water(:)), water_exp, 'LineWidth', 2.5)
water_ray = raylpdf(1:max(water(:)), p_water_ray); %compute the pdf with Rayleigh distribution
hold on; plot(1:max(water(:)), water_ray, 'LineWidth', 2.5)
water_nor = normpdf(1:max(water(:)), p_water_nor(1), p_water_nor(2)); %compute the pdf with normal distribution
hold on; plot(1:max(water(:)), water_nor, 'LineWidth', 2.5)

%% R2.a)
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_nor = mle(water(:), 'distribution', 'Normal');

I_A = zeros(size(I)); %store the image segmented by regions pixel by pixel
for x = 1:size(I, 1)
    for y = 1:size(I, 2)
        prob1 = normpdf(I(x,y), p_ice_nor(1), p_ice_nor(2));
        prob2 = normpdf(I(x,y), p_water_nor(1), p_water_nor(2));
        I_A(x,y) = prob1 < prob2;
    end
end

figure; colormap hsv
imcontour(I_A, 1) %draws the contour of the regions

%% R2.b)
load("sar_image.mat");
ice = imcrop(I, [760 2453 949 188]);
water = imcrop(I, [1 1 629 1234]);
p_ice_nor = mle(ice(:), 'distribution', 'Normal');
p_water_nor = mle(water(:), 'distribution', 'Normal');

I_B = zeros(size(I)); %store the image segmented by regions by 9x9 patch of pixel
for x = 1:size(I, 1)
    for y = 1:size(I, 2)
        val = [];
        for a = -4:4
            for b = -4:4
                c = x + a;
                d = y + b;
                if(c > 0 && c <= size(I, 1) && d > 0 && d <= size(I, 2))                
                    val = [val I(c,d)];
                end
            end
        end
        prob1 = normpdf(val, p_ice_nor(1), p_ice_nor(2));
        prob2 = normpdf(val, p_water_nor(1), p_water_nor(2));
        I_B(x,y) = mean(prob1 < prob2) > 0.5; % if the number of pixels more likely to belong to one region is higher than for the other region 
    end
end

figure; colormap hsv
imcontour(I_B, 1)

%% R2.c)
load("sar_image.mat");
threshold = 90;
I_C = zeros(size(I)); %store the image segmented with a threshold
I_C = I <= threshold;
figure; colormap hsv
imcontour(I_C, 1)

%% R2.d) needs to run R2.a-c) first
ice_A = imcrop(I_A, [760 2453 949 188]);
figure; colormap hsv
imcontour(ice_A, 1)
water_A = imcrop(I_A, [1 1 629 1234]);
figure; colormap hsv
imcontour(water_A, 1)
rate_ice_A = 1 - sum(ice_A(:))/prod(size(ice));
rate_water_A = sum(water_A(:))/prod(size(water));

ice_B = imcrop(I_B, [760 2453 949 188]);
figure; colormap hsv
imcontour(ice_B, 1)
water_B = imcrop(I_B, [1 1 629 1234]);
figure; colormap hsv
imcontour(water_B, 1)
rate_ice_B = 1 - sum(ice_B(:))/prod(size(ice));
rate_water_B = sum(water_B(:))/prod(size(water));

ice_C = imcrop(I_C, [760 2453 949 188]);
figure; colormap hsv
imcontour(ice_C, 1)
water_C = imcrop(I_C, [1 1 629 1234]);
figure; colormap hsv
imcontour(water_C, 1)
rate_ice_C = 1 - sum(ice_C(:))/prod(size(ice));
rate_water_C = sum(water_C(:))/prod(size(water));