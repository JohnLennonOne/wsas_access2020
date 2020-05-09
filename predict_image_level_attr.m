clear
close all
addpath('library');
addpath('library/liblinear-2.20/matlab');
load('~/Desktop/sigir19/pre_work/data/tr_idx.mat');
load('~/Desktop/sigir19/pre_work/data/te_idx.mat');
n_tr = length(tr_idx);
n_te = length(te_idx);

% load('/disks/sdd/nanyi_fei/sigir19/data/image_level/fea_total.mat');
% fea_tr = fea_total(tr_idx, :);
% fea_te = fea_total(te_idx, :);
% fprintf('Start doing pca...\n');
% pca_dim = 850;
% fea_tmp = [fea_tr; fea_te];
% fea_tmp = NormalizeFea(fea_tmp);
% [~, score] = pca(fea_tmp);
% fea_tmp = score(:, 1:pca_dim);
% fea_tr = fea_tmp(1:n_tr, :);
% fea_te = fea_tmp(n_tr+1:end, :);
% clear fea_total fea_tmp score
% fprintf('Finish doing pca.\n');
% save('/disks/sdd/nanyi_fei/sigir19/data/image_level/fea_tr_pca.mat', 'fea_tr');
% save('/disks/sdd/nanyi_fei/sigir19/data/image_level/fea_te_pca.mat', 'fea_te');
load('/disks/sdd/nanyi_fei/sigir19/data/image_level/fea_tr_pca.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/image_level/fea_te_pca.mat');

load('/disks/sdd/nanyi_fei/sigir19/data/image_level/attr_total.mat');
attr_tr = attr_total(tr_idx, :);
attr_te = attr_total(te_idx, :);
attr_tr(attr_tr > 0) = 1;
attr_te(attr_te > 0) = 1;
clear attr_total

attr_dim = size(attr_tr, 2);
predicted_attrs = zeros(n_te, attr_dim);
for step = 1:attr_dim
	y_tr = attr_tr(:, step);
	y_te = attr_te(:, step);
	param = sprintf('-s 2 -c 1 -B 0.01 -q');
	model = train(y_tr, sparse(fea_tr), param);
	[p, acc, ~] = predict(y_te, sparse(fea_te), model);
	predicted_attrs(:, step) = p;
	
% 	tp = 0; fp = 0;
% 	for i = 1:n_te
% 		if y_te(i) == 1 && p(i) == 0
% 			fp = fp + 1;
% 		end
% 		if y_te(i) == 1 && p(i) == 1
% 			tp = tp + 1;
% 		end
% 	end
% 	fprintf('Step %d: %d %d\n', tp, fp);
end
fprintf('-s 2 -c 1 -B 0.01 -q\n');
save('/disks/sdd/nanyi_fei/sigir19/data/image_level/predicted_attrs.mat', 'predicted_attrs');

pr = 0; re = 0;
for i = 1:n_te
    y_pro = predicted_attrs(i, :);
    y_gt = attr_te(i, :);
    idx_tmp = (y_pro == y_gt);
    tp = sum(y_gt(idx_tmp) == 1);
    idx_tmp = (y_pro ~= y_gt);
    fp = sum(y_gt(idx_tmp) == 0);
    fn = sum(y_gt(idx_tmp) == 1);
    if tp == 0
        pri = 0;
        rei = 0;
    else
        pri = tp / (tp + fp);
        rei = tp / (tp + fn);
    end
    pr = pr + pri;
    re = re + rei;
end
pr = pr / n_te;
re = re / n_te;
fm = 2 * pr * re / (pr + re);
fprintf('image-wise: %.6f %.6f %.6f\n', pr, re, fm);



