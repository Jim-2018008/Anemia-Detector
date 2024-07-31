% Read the original image
originalImage = imread('E:\ML Project\Anemia\yeakub.jpg');

% Convert the image to grayscale
grayImage = rgb2gray(originalImage);

% Apply Sobel edge detection
edgeImage = edge(grayImage, 'Sobel');

% Find connected components using bwconncomp
cc = bwconncomp(edgeImage);
stats = regionprops(cc, 'Area');

% Find the index of the connected component with the largest area
[~, maxIndex] = max([stats.Area]);

% Extract the largest connected component
largestComponentMask = false(size(edgeImage));
largestComponentMask(cc.PixelIdxList{maxIndex}) = true;

% Crop the image based on the largest connected component
croppedImage = originalImage .* uint8(repmat(largestComponentMask, [1, 1, size(originalImage, 3)]));

% Display the original and cropped images
figure;
subplot(1, 2, 1), imshow(originalImage), title('Original Image');
subplot(1, 2, 2), imshow(croppedImage), title('Cropped Image');