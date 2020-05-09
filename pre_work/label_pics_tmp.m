

load('/home/nanyi_fei/Desktop/sigir19/pre_work/data/te_idx.mat');
% load('/data3/nanyi_fei/sigir19/cub/head/all_labels.mat');
% te_labels = all_labels(te_idx);
% [~, IA] = unique(te_labels);
% IA = [IA; length(te_labels) + 1];

% load('/data3/nanyi_fei/sigir19/data/head_flag_te.mat');
load('/data3/nanyi_fei/sigir19/labeled_pics/tete_idx.mat');
% load('/data3/nanyi_fei/sigir19/original_features/sp_cnt.mat');
% sp_cnt_te = sp_cnt(te_idx);
% sp_cnt_te_cumsum = cumsum(sp_cnt_te);
% sp_cnt_te_cumsum = [0; sp_cnt_te_cumsum];

% flag = zeros(50, 49);
% for class = 151:200;
%     valid_idx = te_idx(IA(class):IA(class+1)-1);
%     flag(class-150, :) = ismember(tete_idx, valid_idx);
% end

% tete_fea = [];
% tete_labels = [];
% sp_to_img_tete = [];
% head_flag_tete = [];
tete_pixel_num = [];
for tmpi = 1:length(tete_idx)
    imgi = tete_idx(tmpi);
    load_path = sprintf('/data3/nanyi_fei/sigir19/labeled_pics/pic%d.mat', ...
                        tete_idx(tmpi));
    load(load_path);
    load_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', ...
                        tete_idx(tmpi));
    load(load_path);
    
%     tete_fea_tmp = features(sp_idxs, :);
%     tete_fea = [tete_fea; tete_fea_tmp];
%     
%     [~, tete_labels_tmp] = max(tete_labels_i, [], 2);
%     tete_labels = [tete_labels; tete_labels_tmp];
%     
%     find_tmp = find(te_idx == tete_idx(tmpi));
%     sp_to_img_tete_tmp = ones(length(sp_idxs), 1) * find_tmp;
%     sp_to_img_tete = [sp_to_img_tete; sp_to_img_tete_tmp];
%     
%     sp_idxs_tmp = sp_idxs + sp_cnt_te_cumsum(find_tmp);
%     head_flag_tete_tmp = head_flag_te(sp_idxs_tmp, :);
%     head_flag_tete = [head_flag_tete; head_flag_tete_tmp];
    
    tete_pixel_num_tmp = sp_num(sp_idxs, :);
    tete_pixel_num = [tete_pixel_num; tete_pixel_num_tmp];
end


