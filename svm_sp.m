clear
close all
addpath('/home/nanyi_fei/Desktop/sigir19/library');
addpath('/home/nanyi_fei/Desktop/sigir19/library/liblinear-2.20/matlab');

load('/disks/sdd/nanyi_fei/sigir19/data/fea_tr.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/fea_te.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/Y7.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/head_flag_te.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/sp_to_img_te.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/image_level/attr_te_pro.mat');
load('/disks/sdd/nanyi_fei/sigir19/data/image_level/attr_te.mat');

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
fea_te(:, 129) = fea_te(:, 129) ./ 100;
fea_te(:, 130:131) = fea_te(:, 130:131) ./ 128;
fea_te(:, 132:135) = fea_te(:, 132:135) ./ 256;

attr_dim = size(attr_te_pro, 2);
n_te = size(fea_te, 1);
fprintf('-s 2 -c 30 -B 0.01 -q\n');
% param = sprintf('-s 2 -c 30 -B 0.01 -q');
% model = train(y_tr, sparse(fea_tr), param);
% save('/home/nanyi_fei/Desktop/sigir19/data/model.mat', 'model');
load('/home/nanyi_fei/Desktop/sigir19/data/model_l2.mat');
[p, acc, score_tmp] = predict(zeros(n_te, 1), sparse(fea_te), model);
score = ones(n_te, attr_dim) * (-inf);
for i = 1:length(model.Label)
    score(:, model.Label(i)) = score_tmp(:, i);
end

max_num = 1;
attr_sp_te = zeros(n_te, max_num);
parfor i = 1:n_te
    scorei = score(i, :);
    headi = head_flag_te(i, :);
    tmp = sp_to_img_te(i);
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
    idx = (idx2);
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

attr_sp2img = zeros(size(attr_te_pro));
for i = 1:n_te
    tmp = sp_to_img_te(i);
    idx = attr_sp_te(i, :);
    idx = idx(idx > 0);
    attr_sp2img(tmp, idx) = 1;
end
% for i = 1:n_te
%     tmp = sp_to_img_te(i);
%     imgi = attr_te_pro(tmp, :);
%     idx2 = (imgi == 1);
%     attr_sp2img(tmp, idx2) = 1;
% end


fprintf('%d/sp_tr, %d/sp_te\n', max_num0, max_num);
eval_(attr_sp2img, attr_te);






