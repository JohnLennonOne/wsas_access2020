% for each image

function eval_(pro, gt)

n = size(gt, 1);
k = size(gt, 2);

pr = 0;
re = 0;
for i = 1:n
    y_pro = pro(i, :);
    y_gt = gt(i, :);
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
pr = pr / n;
re = re / n;
fm = 2 * pr * re / (pr + re);
fprintf('image-wise: %.6f %.6f %.6f\n', pr, re, fm);

pr = 0;
re = 0;
for i = 1:k
    y_pro = pro(:, i);
    y_gt = gt(:, i);
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
pr = pr / k;
re = re / k;
fm = 2 * pr * re / (pr + re);
fprintf('attribute-wise: %.6f %.6f %.6f\n', pr, re, fm);

end


