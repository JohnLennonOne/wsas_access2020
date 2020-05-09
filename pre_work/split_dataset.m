% load cub_train_images.txt cub_test_images.txt
tr_idx_str = cubtrainimages.Black_footed_AlbatrossBlack_Footed_Albatross_0009_34jpg;
te_idx_str = cubtestimages.Black_footed_AlbatrossBlack_Footed_Albatross_0046_18jpg;
clear cubtrainimages cubtestimages
load('/data3/nanyi_fei/sigir19/cub/img_paths.mat');
load('/data3/nanyi_fei/sigir19/cub/head/all_labels.mat');
[~, IA] = unique(all_labels);
IA = [IA; length(all_labels) + 1];

ntr = length(tr_idx_str);
nte = length(te_idx_str);
tr_idx = zeros(ntr, 1);
te_idx = zeros(nte, 1);

tr_ptr = 1;
for i = 1:ntr
    flag = false;
    while ~flag
        for j = IA(tr_ptr):(IA(tr_ptr + 1) - 1)
            if strcmp(tr_idx_str(i), img_paths{j})
                flag = true;
                tr_idx(i) = j;
            end
        end
        if ~flag
            tr_ptr = tr_ptr + 1;
        end
    end
end

te_ptr = 1;
for i = 1:nte
    flag = false;
    while ~flag
        for j = IA(te_ptr):(IA(te_ptr + 1) - 1)
            if strcmp(te_idx_str(i), img_paths{j})
                flag = true;
                te_idx(i) = j;
            end
        end
        if ~flag
            te_ptr = te_ptr + 1;
        end
    end
end

tr_idx = sort(tr_idx, 'ascend');
te_idx = sort(te_idx, 'ascend');

save('~/Desktop/sigir19/pre_work/data/tr_idx.mat', 'tr_idx');
save('~/Desktop/sigir19/pre_work/data/te_idx.mat', 'te_idx');

























