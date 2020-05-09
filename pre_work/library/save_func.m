function save_func(i, features, attrs, L, sp_to_label, head_flag)

save_path = sprintf('/data3/nanyi_fei/sigir19/original_features/sp%d.mat', i);
save(save_path, 'features', 'attrs', 'L', 'sp_to_label', 'head_flag');

end

