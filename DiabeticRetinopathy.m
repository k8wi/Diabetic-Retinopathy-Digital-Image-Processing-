% Load the image
img = imread('ret.jpg');

% Convert the image to grayscale
gray_img = rgb2gray(img);

% Apply contrast adjustment to enhance the image
contrast_adjusted_img = imadjust(gray_img, stretchlim(gray_img), []);

% Apply median filtering to reduce noise
filtered_img = medfilt2(contrast_adjusted_img, [3 3]);

% Apply watershed segmentation to separate the blood vessels from the background
segmented_img = watershed(filtered_img);

% Find the optic disc
[centers, radii] = imfindcircles(segmented_img, [50 100], 'ObjectPolarity', 'bright');

% Draw a circle around the optic disc
figure, imshow(img);
viscircles(centers, radii, 'EdgeColor', 'b');

% Calculate the area of the optic disc
optic_disc_area = pi * radii.^2;

% Calculate the number of microaneurysms
microaneurysms = bwlabel(segmented_img);
num_microaneurysms = max(microaneurysms(:));

% Display the results
fprintf('Optic disc area: %f\n', optic_disc_area);
fprintf('Number of microaneurysms: %d\n', num_microaneurysms);
Optic disc area: 
Number of microaneurysms: 229
