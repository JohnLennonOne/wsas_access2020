function bw_bb = saliency(img, bb)

addpath('~/Desktop/sigir19/pre_work/library/MBS');

% MB+
paramMBplus = getParam();
[pMap, ~] = doMBS(img, paramMBplus);

[~, threshold] = edge(pMap, 'sobel');
fudgeFactor = .5;
bws = edge(pMap, 'sobel', threshold * fudgeFactor);

se90 = strel('line', 5, 90);
se0 = strel('line', 5, 0);
bwsdil = imdilate(bws, [se90 se0]);

bwdfill = imfill(bwsdil, 'holes');

seD = strel('diamond', 1);
bwfinal = imerode(bwdfill, seD);
bwfinal = imerode(bwfinal, seD);
bwfinal = imerode(bwfinal, seD);
bwfinal = bwfinal(bb(2):(bb(2)+bb(4)-1), bb(1):(bb(1)+bb(3)-1));

cc = bwconncomp(bwfinal, 8);
stat = regionprops(cc, 'Area');
num_pixels = cellfun(@numel, cc.PixelIdxList);
[~, idx] = max(num_pixels);
bw_bb = false(size(bwfinal));
bw_bb(cc.PixelIdxList{idx}) = true;


% figure;
% subplot(3, 3, 1);
% imshow(img);
% subplot(3, 3, 2);
% imshow(pMap);
% subplot(3, 3, 3);
% imshow(bws);
% subplot(3, 3, 4);
% imshow(bwsdil);
% subplot(3, 3, 5);
% imshow(bwdfill);
% subplot(3, 3, 6);
% imshow(bwfinal);
% subplot(3, 3, 7);
% imshow(bw_bb);
end




