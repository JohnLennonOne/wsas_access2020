% clear
% close all
addpath('/home/nanyi_fei/Desktop/sigir19/library/liblinear-2.20/matlab');

load('/data3/nanyi_fei/sigir19/data/sp_to_img_te.mat');
% load('/data3/nanyi_fei/sigir19/data/head_flag_te.mat');
% load('/data3/nanyi_fei/sigir19/data/image_level/attr_te_pro.mat');
% load('/data3/nanyi_fei/sigir19/data/fea_te.mat');
% load('/home/nanyi_fei/Desktop/sigir19/data/model.mat');
% fea_te(:, 129) = fea_te(:, 129) ./ 100;
% fea_te(:, 130:131) = fea_te(:, 130:131) ./ 128;
% fea_te(:, 132:135) = fea_te(:, 132:135) ./ 256;
% 
% attr_dim = size(attr_te_pro, 2);
% n_te = size(fea_te, 1);
% [~, ~, score_tmp] = predict(zeros(n_te, 1), sparse(fea_te), model);
% score = ones(n_te, attr_dim) * (-inf);
% for i = 1:length(model.Label)
%     score(:, model.Label(i)) = score_tmp(:, i);
% end
% clear score_tmp
% 
% max_num = 1;
% attr_sp_te = zeros(n_te, max_num);
% parfor i = 1:n_te
%     scorei = score(i, :);
%     headi = head_flag_te(i, :);
%     tmp = sp_to_img_te(i);
%     imgi = attr_te_pro(tmp, :);
%     % head
%     idx1 = false(1, attr_dim);
%     if headi(1)
%         idx1(1:56) = true;
%     end
%     if headi(2)
%         idx1(57:end) = true;
%     end
%     % img
%     idx2 = (imgi == 1);
%     % combine above
%     idx = (idx1 & idx2);
%     tmp = find(idx == true);
%     scorei = scorei(idx);
%     if length(scorei) >= max_num
%         [~, max_idx] = maxk(scorei, max_num);
%         max_idx = tmp(max_idx);
%     else
%         max_idx = zeros(1, max_num);
%         max_idx(1:length(tmp)) = tmp;
%     end
%     attr_sp_te(i, :) = max_idx;
% end
% save('/data3/nanyi_fei/sigir19/examples/data/attr_sp_te.mat', 'attr_sp_te');

load('/data3/nanyi_fei/sigir19/examples/data/attr_sp_te.mat');
load('/home/nanyi_fei/Desktop/sigir19/pre_work/data/te_idx.mat');
load('/data3/nanyi_fei/sigir19/cub/bounding_boxes.mat');
bb = bounding_boxes;
zero_idx = find(bb(:, 1) == 0);
bb(zero_idx, 1) = bb(zero_idx, 1) + 1;
zero_idx = find(bb(:, 2) == 0);
bb(zero_idx, 2) = bb(zero_idx, 2) + 1;
clear bounding_boxes zero_idx
load('/data3/nanyi_fei/sigir19/cub/img_paths.mat');
imgs_path = '/data3/nanyi_fei/CUB_200_2011/CUB_200_2011/images/';
load('/data3/nanyi_fei/sigir19/original_features/sp_cnt.mat');
sp_cnt_te = sp_cnt(te_idx);
sp_cnt_te_cumsum = cumsum(sp_cnt_te);
sp_cnt_te_cumsum = [0; sp_cnt_te_cumsum];

attr_assign = [136, 149];
attr_dim = 192;
n_te = size(attr_sp_te, 1);

assign_idx = [];
flag = false(n_te, length(attr_assign));
for i = 1:n_te
    [LIA, LOCB] = ismember(attr_sp_te(i, :), attr_assign);
    if sum(LIA) > 0
        assign_idx = [assign_idx; i];
        tmp = find(LOCB > 0);
        flag(i, LOCB(tmp)) = true;
    end
end
flag = flag(assign_idx, :);
if ismember([0], sum(flag, 2))
    fprintf('ERROR!\n');
end
assign_sp2img_te = sp_to_img_te(assign_idx);
[~, IA] = unique(assign_sp2img_te);
IA = [IA; length(assign_sp2img_te) + 1];
img_num = length(IA) - 1;

% must have [attr_assign]'s all attributes in one image
delete_idx = [];
for i = 1:img_num
    st = IA(i);
    ed = IA(i + 1) - 1;
    if ismember([0], sum(flag(st:ed, :)))
        delete_idx = [delete_idx, st:ed];
    end
end
flag(delete_idx, :) = [];
assign_idx(delete_idx) = [];
assign_sp2img_te(delete_idx) = [];
[~, IA] = unique(assign_sp2img_te);
IA = [IA; length(assign_sp2img_te) + 1];
img_num = length(IA) - 1;

for i = 4%1:img_num
    i_te = assign_sp2img_te(IA(i));
    ii = te_idx(i_te);
    st = IA(i);
    ed = IA(i + 1) - 1;
    assign_idxi = assign_idx(st:ed) - sp_cnt_te_cumsum(i_te);
    img_path = strcat(imgs_path, img_paths(ii));
    img_path = img_path{1};
    img = imread(img_path);
    bbi = bb(ii, :);
    if bbi(2) + bbi(4) - 1 > size(img, 1)
        bbi(4) = size(img, 1) - bbi(2) + 1;
        if bbi(4) < 1
            bbi(1) = 1;
            bbi(2) = 1;
            bbi(3) = size(img, 2);
            bbi(4) = size(img, 1);
        end
    end
    if bbi(1) + bbi(3) - 1 > size(img, 2)
        bbi(3) = size(img, 2) - bbi(1) + 1;
        if bbi(3) < 1
            bbi(1) = 1;
            bbi(2) = 1;
            bbi(3) = size(img, 2);
            bbi(4) = size(img, 1);
        end
    end
    img_b = img(bbi(2):(bbi(2)+bbi(4)-1), bbi(1):(bbi(1)+bbi(3)-1), :);
    sp_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', ii);
    load(sp_path);
    sp_to_labeli = sp_to_label(assign_idxi);
    L(~ismember(L, sp_to_labeli)) = 0;
    bm = boundarymask(L);
    figure;
    imshow(imoverlay(img_b, bm, 'yellow'));
end





















