%%%%%% explanation %%%%%%
% ||Y - Z||_F + lambda1 * ||B * Z'||_F
% 8. X: d * Ns
% 9. Y0: K * Ns
%%%%%% explanation %%%%%%
clear
close all
addpath('/disks/sdd/nanyi_fei/sigir19/data');
addpath('data');
addpath('library');
load('fea_tr.mat');
load('attr_tr.mat');
X = fea_tr';
Y0 = attr_tr';
clear fea_tr attr_tr

num_eigs = 50;
max_iter = 10;
lambda1 = 0.01;
lambda2 = 0.25;
EPS = 5e-4;

fprintf('lambda1 = %.6f, lambda2 = %.6f\n', lambda1, lambda2);

% [S, Vm] = Lap(X', num_eigs, 50);
% save('data/S.mat', 'S');
% save('data/Vm.mat', 'Vm');
load('S.mat');
load('Vm.mat');
[k, N] = size(Y0);
Y = Y0;

for t = 1:max_iter
    fprintf('Iter %d: Updating Z...\n', t);
    Z = Y * Vm * diag(1 ./ (ones(num_eigs, 1) + lambda1 * (S .^ 2))) * Vm';
    Z(Z < EPS) = 0;

    fprintf('Iter %d: Updating Y...\n', t);
    Y = Z;
    save_path = sprintf('/disks/sdd/nanyi_fei/sigir19/data/Y_l2_%d.mat', t);
    save(save_path, 'Y');
end




