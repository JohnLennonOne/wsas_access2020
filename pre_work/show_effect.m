% clear
% close all
% 
% load('/data3/nanyi_fei/sigir19/cub/bounding_boxes.mat');
% load('/data3/nanyi_fei/sigir19/cub/img_paths.mat');
% bb = bounding_boxes;
% zero_idx = find(bb(:, 1) == 0);
% bb(zero_idx, 1) = bb(zero_idx, 1) + 1;
% zero_idx = find(bb(:, 2) == 0);
% bb(zero_idx, 2) = bb(zero_idx, 2) + 1;
% clear bounding_boxes zero_idx
% imgs_path = '/data3/nanyi_fei/CUB_200_2011/CUB_200_2011/images/';
% load('~/Desktop/sigir19/pre_work/data/te_idx.mat');
% load('/data3/nanyi_fei/sigir19/cub/head/all_labels.mat');
% te_labels = all_labels(te_idx);
% [~, IA] = unique(te_labels);
% IA = [IA; length(te_labels) + 1];
% clear all_labels te_labels

class = 120;
valid_idx = te_idx(IA(class):IA(class+1)-1);

for vii = 1:length(valid_idx)
    i = valid_idx(vii); % must be in valid_idx
    img_path = strcat(imgs_path, img_paths(i));
    img_path = img_path{1};
    img = imread(img_path);
    bbi = bb(i, :);
    if bbi(2) + bbi(4) - 1 > size(img, 1)
        bbi(4) = size(img, 1) - bbi(2) + 1;
        if bbi(4) < 1
            bbi(1) = 1;
            bbi(2) = 1;
            bbi(3) = size(img, 2);
            bbi(4) = size(img, 1);
        end
    end
    if bbi(1)+bbi(3)-1 > size(img, 2)
        bbi(3) = size(img, 2) - bbi(1) + 1;
        if bbi(3) < 1
            bbi(1) = 1;
            bbi(2) = 1;
            bbi(3) = size(img, 2);
            bbi(4) = size(img, 1);
        end
    end
    img_b = img(bbi(2):(bbi(2)+bbi(4)-1), bbi(1):(bbi(1)+bbi(3)-1), :);
    sp_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', i);
    load(sp_path);
    L(~ismember(L, sp_to_label)) = 0;
    bm = boundarymask(L);
    figure;
    imshow(imoverlay(img_b, bm, 'yellow'));
end





