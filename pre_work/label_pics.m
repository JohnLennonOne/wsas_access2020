% load('~/Desktop/sigir19/pre_work/data/labeled_pics/tete_idx.mat');
% addpath('~/Desktop/sigir19/pre_work/library');

% tete_idx = [tete_idx; i];
% tete_labels_i = zeros(size(attrs));
% sp_idxs = (1:length(sp_to_label))';
% attr_details = get_attr_details(i);

% x = 58;
% y = 121;
% attr_label = 177;
% sp_label = L(y, x);
% sp_idx = find(sp_to_label == sp_label);
% tete_labels_i(sp_idx, attr_label) = 1;

% zero_idx = find(sum(tete_labels_i, 2) == 0);
% tete_labels_i(zero_idx, :) = [];
% sp_idxs(zero_idx) = [];
% save_path = sprintf('~/Desktop/sigir19/pre_work/data/labeled_pics/pic%d.mat', i);
% save(save_path, 'tete_labels_i', 'sp_idxs');
% save('~/Desktop/sigir19/pre_work/data/labeled_pics/tete_idx.mat', 'tete_idx');









