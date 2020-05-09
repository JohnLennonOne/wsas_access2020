%     [L, n_sp] = superpixels(img_b, 100);
%     bm = boundarymask(L);
%     imshow(imoverlay(img_b, bm, 'cyan'));
% 
% attribute parts:
% beak 27 (1-9, 150-152, 279-293)
% belly 19 (198-212, 245-248)
% crown 15 (294-308)
% tail 40 (74-94, 168-182, 241-244)
% back 19 (59-73, 237-240)
% eye 14 (136-149)
% wing 24 (10-24, 213-217, 309-312)
% breast 19 (55-58, 106-120)
% leg 15 (264-278)
% head 56 (beak, crown, eye) (1-9, 136-152, 279-308)
% non-head 136 (belly, tail, back, wing, breast, leg) (10-24, 55-94, 106-120, 168-182, 198-217, 237-248, 264-278, 309-312)
% together 192 (1-24, 55-94, 106-120, 136-152, 168-182, 198-217, 237-248, 264-312)


% clear
% close all
% addpath('data');
% addpath('library');
% addpath('/data3/nanyi_fei/sigir19/cub');
% load('img_paths.mat');
% load('bounding_boxes.mat');
% load('total_attr.mat');
% load('head.mat');
% n_img = size(bounding_boxes, 1);
% bb = bounding_boxes;
% zero_idx = find(bb(:, 1) == 0);
% bb(zero_idx, 1) = bb(zero_idx, 1) + 1;
% zero_idx = find(bb(:, 2) == 0);
% bb(zero_idx, 2) = bb(zero_idx, 2) + 1;
% clear bounding_boxes
% imgs_path = '/data3/nanyi_fei/CUB_200_2011/CUB_200_2011/images/';
% sp_cnt = zeros(n_img, 1);
% 
% parfor i = 1:n_img
%     % prepare images
%     bbi = bb(i, :);
%     headi = head(i, :);
%     img_path = strcat(imgs_path, img_paths(i));
%     img_path = img_path{1};
%     img = imread(img_path);
%     if bbi(2) + bbi(4) - 1 > size(img, 1)
%         bbi(4) = size(img, 1) - bbi(2) + 1;
%         if bbi(4) < 1
%             bbi(1) = 1;
%             bbi(2) = 1;
%             bbi(3) = size(img, 2);
%             bbi(4) = size(img, 1);
%         end
%     end
%     if bbi(1)+bbi(3)-1 > size(img, 2)
%         bbi(3) = size(img, 2) - bbi(1) + 1;
%         if bbi(3) < 1
%             bbi(1) = 1;
%             bbi(2) = 1;
%             bbi(3) = size(img, 2);
%             bbi(4) = size(img, 1);
%         end
%     end
%     if length(size(img)) == 2
%         img = repmat(img, 1, 1, 3);
%     end
%     img_b = img(bbi(2):(bbi(2)+bbi(4)-1), bbi(1):(bbi(1)+bbi(3)-1), :);
%     img_lab = rgb2lab(img);
%     img_gray = rgb2gray(img);
%     
%     % prepare masks
%     bw_bb = saliency(img, bbi);
%     slc_mask = false(size(img, 1), size(img, 2));
%     slc_mask(bbi(2):(bbi(2)+bbi(4)-1), bbi(1):(bbi(1)+bbi(3)-1)) = bw_bb;
%     bw_bb = [];
%     head_mask = false(size(img, 1), size(img, 2));
%     if headi(1) > 0
%         head_mask(headi(2):headi(4), headi(1):headi(3)) = true;
%     end
%     
%     [L, n_sp] = superpixels(img_b, 50);
%     
%     % prepare features
%     sp_flag = false(n_sp, 3); % in bw_bb; in head; out of head
%     sp_num = zeros(n_sp, 2);
%     features = zeros(n_sp, 135);
%     tmp_fea = zeros(2, 3);
%     bb_h = size(img_b, 1);
%     bb_w = size(img_b, 2);
%     locations = zeros(bb_h * bb_w, 2);
%     tmp = (bbi(1):(bb_w + bbi(1) - 1))';
%     locations(:, 1) = repmat(tmp, bb_h, 1);
%     tmp = bbi(2):(bb_h + bbi(2) - 1);
%     tmp = repmat(tmp, bb_w, 1);
%     locations(:, 2) = reshape(tmp, bb_h * bb_w, 1);
%     points = SURFPoints(locations);
%     all_features = extractFeatures(img_gray, points, 'Method', 'SURF', ...
%                                    'FeatureSize', 128);
%     tmp = [];
%     locations = [];
%     points = [];
%     for x = 1:size(img_b, 1)
%         for y = 1:size(img_b, 2)
%             x_o = x + bbi(2) - 1;
%             y_o = y + bbi(1) - 1;
%             sp_idx = L(x, y);
%             
% %             point = SURFPoints([y_o, x_o]);
% %             features(sp_idx, 1:128) = features(sp_idx, 1:128) + ...
% %                 extractFeatures(img_gray, point, 'Method', 'SURF', ...
% %                 'FeatureSize', 128);
%             
%             features(sp_idx, 1:128) = features(sp_idx, 1:128) + ...
%                                       all_features((x - 1)* bb_w + y, :);
%             for tmpi = 1:3
%                 tmp_fea(1, tmpi) = img_lab(x_o, y_o, tmpi);
%                 tmp_fea(2, tmpi) = img(x_o, y_o, tmpi);
%             end
%             features(sp_idx, 129:131) = features(sp_idx, 129:131) + ...
%                                         tmp_fea(1, :);
%             features(sp_idx, 132:134) = features(sp_idx, 132:134) + ...
%                                         tmp_fea(2, :);
%             features(sp_idx, 135) = features(sp_idx, 135) + img_gray(x_o, y_o);
%             sp_num(sp_idx, 1) = sp_num(sp_idx, 1) + 1;
%             
%             if slc_mask(x_o, y_o)
%                 sp_num(sp_idx, 2) = sp_num(sp_idx, 2) + 1;
%             end
%             if head_mask(x_o, y_o)
%                 sp_flag(sp_idx, 2) = true;
%             else
%                 sp_flag(sp_idx, 3) = true;
%             end
%         end
%     end
%     all_features = [];
%     
%     tmp = sp_num(:, 2) ./ sp_num(:, 1);
%     sp_flag(:, 1) = (tmp > 0.2);
%     
%     sp_to_label = (1:n_sp)';
%     head_flag = sp_flag(:, 2:end);
%     attri = total_attr(i, :);
%     del_idx = find(sp_flag(:, 1) == 0);
%     features(del_idx, :) = [];
%     sp_to_label(del_idx) = [];
%     head_flag(del_idx, :) = [];
%     sp_num(del_idx, :) = [];
%     n_sp = n_sp - length(del_idx);
%     attrs = zeros(n_sp, 192);
%     for sp_idx = 1:n_sp
%         features(sp_idx, :) = features(sp_idx, :) ./ sp_num(sp_idx, 1);
%         if sp_flag(sp_idx, 2) && (~sp_flag(sp_idx, 3))
%             % only the head
%             attrs(sp_idx, :) = attr_head(attri);
%         elseif (~sp_flag(sp_idx, 2)) && sp_flag(sp_idx, 3)
%             % only the body
%             attrs(sp_idx, :) = attr_non_head(attri);
%         else
%             % all
%             attrs(sp_idx, :) = attr_all(attri);
%         end
%     end
%     
%     sp_cnt(i) = n_sp;
%     save_func(i, features, attrs, L, sp_to_label, head_flag);
% end
% 
% save('/data3/nanyi_fei/sigir19/original_features/sp_cnt.mat', 'sp_cnt');





n_img = 11788;
for i = 1:n_img
    if i == 1000
        fprintf('1000');
    end
    
    file_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', i);
    load(file_path);
    
    n_sp = length(sp_to_label);
    sp_num = zeros(n_sp, 1);
    for spi = 1:n_sp
        sp_num(spi) = sum(sum(L == sp_to_label(spi)));
    end
    
    save(file_path, 'features', 'attrs', 'L', 'sp_to_label', 'head_flag', ...
         'sp_num');
end


















