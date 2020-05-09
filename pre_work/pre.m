clear
close all
load('data/tr_idx.mat');
load('data/te_idx.mat');

fea_tr = [];
attr_tr = [];
for ii = 1:length(tr_idx)
    i = tr_idx(ii);
    sp_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', i);
    load(sp_path);
    fea_tr = [fea_tr; features];
    attr_tr = [attr_tr; attrs];
end

fea_te = [];
head_flag_te = [];
for ii = 1:length(te_idx)
    i = te_idx(ii);
    sp_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', i);
    load(sp_path);
    fea_te = [fea_te; features];
    head_flag_te = [head_flag_te; head_flag];
end

save('/data3/nanyi_fei/sigir19/data/fea_tr.mat', 'fea_tr');
save('/data3/nanyi_fei/sigir19/data/attr_tr.mat', 'attr_tr');
save('/data3/nanyi_fei/sigir19/data/fea_te.mat', 'fea_te');
save('/data3/nanyi_fei/sigir19/data/head_flag_te.mat', 'head_flag_te');

load('/data3/nanyi_fei/sigir19/original_features/sp_cnt.mat');
sp_cnt_te = sp_cnt(te_idx, :);
sp_to_img_te = zeros(size(fea_te, 1), 1);
pt = 1;
for i = 1:length(sp_cnt_te)
    ed = pt + sp_cnt_te(i) - 1;
    sp_to_img_te(pt:ed) = i;
    pt = ed + 1;
end
save('/data3/nanyi_fei/sigir19/data/sp_to_img_te.mat', 'sp_to_img_te');





