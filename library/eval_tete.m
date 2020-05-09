function eval_tete(pro, gt)

load('/disks/sdd/nanyi_fei/sigir19/data/labeled_pics/tete_pixel_num.mat');
attr_dim = 192;

correct_idx = find(pro - gt == 0);
cr_sp = length(correct_idx);
all_sp = length(gt);
cr_p = sum(tete_pixel_num(correct_idx));
all_p = sum(tete_pixel_num);

acc_msp = 0;
acc_mp = 0;
attr_nonzero = 0;
for i = 1:attr_dim
    idx_tmp = find(gt == i);
    if idx_tmp ~= 0
        attr_nonzero = attr_nonzero + 1;
        pro_i = pro(idx_tmp);
        gt_i = gt(idx_tmp);
        tete_pixel_num_i = tete_pixel_num(idx_tmp);

        correct_idx_i = find(pro_i - gt_i == 0);
        cr_sp_i = length(correct_idx_i);
        all_sp_i = length(gt_i);
        cr_p_i = sum(tete_pixel_num_i(correct_idx_i));
        all_p_i = sum(tete_pixel_num_i);

        acc_msp = acc_msp + cr_sp_i / all_sp_i;
        acc_mp = acc_mp + cr_p_i / all_p_i;
    end
end
acc_msp = acc_msp / attr_nonzero;
acc_mp = acc_mp / attr_nonzero;
    
fprintf('per superpixel accuracy: %.6f%%\n', cr_sp / all_sp * 100);
fprintf('per pixel accuracy: %.6f%%\n', cr_p / all_p * 100);
fprintf('mean per superpixel accuracy: %.6f%%\n', acc_msp * 100);
fprintf('mean per pixel accuracy: %.6f%%\n', acc_mp * 100);

end
