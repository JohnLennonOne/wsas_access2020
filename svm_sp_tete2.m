clear
close all
addpath('/home/nanyi_fei/Desktop/sigir19/library');
addpath('/home/nanyi_fei/Desktop/sigir19/library/liblinear-2.20/matlab');

load('/disks/sdd/nanyi_fei/sigir19/data/fea_tr.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/labeled_pics/tete_fea.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/Y7.mat');
load('/home/nanyi_fei/Desktop/sigir19/pre_work/data/color_idx.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/labeled_pics/head_flag_tete.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/labeled_pics/sp_to_img_tete.mat');
% load('/disks/sdd/nanyi_fei/sigir19/data/image_level/attr_te_pro.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/image_level/predicted_attrs.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/labeled_pics/tete_labels.mat');
attr_te_pro = predicted_attrs;

max_num0 = 1;
Y = Y';
[~, tmp] = maxk(Y, max_num0, 2);
attr_sp_tr = zeros(size(Y));
for i = 1:size(Y, 1)
    attr_sp_tr(i, tmp(i, :)) = 1;
end
% save('/data3/nanyi_fei/sigir19/data/attr_sp_tr.mat', 'attr_sp_tr');
% load('/data3/nanyi_fei/sigir19/data/attr_sp_tr.mat');
[~, y_tr] = max(attr_sp_tr, [], 2);
clear attr_sp_tr
fea_tr(:, 129) = fea_tr(:, 129) ./ 100;
fea_tr(:, 130:131) = fea_tr(:, 130:131) ./ 128;
fea_tr(:, 132:135) = fea_tr(:, 132:135) ./ 256;
tete_fea(:, 129) = tete_fea(:, 129) ./ 100;
tete_fea(:, 130:131) = tete_fea(:, 130:131) ./ 128;
tete_fea(:, 132:135) = tete_fea(:, 132:135) ./ 256;
% fea_tr = NormalizeFea(fea_tr);
% tete_fea = NormalizeFea(tete_fea);

attr_dim = size(attr_te_pro, 2);
n_te = size(tete_fea, 1);
fprintf('-s 2 -c 30 -B 0.01 -q\n');
% param = sprintf('-s 2 -c 30 -B 0.01 -q');
% model = train(y_tr, sparse(fea_tr), param);
% save('/home/nanyi_fei/Desktop/sigir19/data/model.mat', 'model');
load('/home/nanyi_fei/Desktop/sigir19/data/model.mat');
[p, acc, score_tmp] = predict(tete_labels, sparse(tete_fea), model);
score = ones(n_te, attr_dim) * (-inf);
for i = 1:length(model.Label)
    score(:, model.Label(i)) = score_tmp(:, i);
end

max_num = 1;
attr_sp_te = zeros(n_te, max_num);
parfor i = 1:n_te
    scorei = score(i, :);
    headi = head_flag_tete(i, :);
    tmp = sp_to_img_tete(i);
    imgi = attr_te_pro(tmp, :);
    
    % head
    idx1 = false(1, attr_dim);
    if headi(1)
        idx1(1:56) = true;
    end
    if headi(2)
        idx1(57:end) = true;
    end
    
    % img
    idx2 = (imgi == 1);
    
    % combine above
    idx = ((idx1 & idx2) & color_idx);
    tmp = find(idx == true);
    scorei = scorei(idx);
    
    if length(scorei) >= max_num
        [~, max_idx] = maxk(scorei, max_num);
        max_idx = tmp(max_idx);
    else
        max_idx = zeros(1, max_num);
        max_idx(1:length(tmp)) = tmp;
    end
    attr_sp_te(i, :) = max_idx;
end

eval_tete(attr_sp_te, tete_labels);




