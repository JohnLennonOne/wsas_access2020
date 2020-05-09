%%%%%% explanation %%%%%%
% ||Y - Z||_F + lambda1 * ||B * Z'||_1 + lambda2 * ||Y - Y0||_1
% 8. X: d * Ns
% 9. Y0: K * Ns
%%%%%% explanation %%%%%%
clear
close all
addpath('/data3/nanyi_fei/sigir19/data');
addpath('library/L1General');
addpath('data');
addpath('library');
load('fea_tr.mat');
load('attr_tr.mat');
X = fea_tr';
Y0 = attr_tr';
clear fea_tr attr_tr

options.maxIter      = 500; % Number of iterations
options.verbose      = 0;   % Set to 0 to turn off output
options.corrections  = 10;  % Number of corrections to store
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
z_l1_weight = lambda1 * S;
y_l1_weight = lambda2 * ones(k, 1);
Y = Y0;

max_idx = zeros(max_iter + 1, N);
sums = zeros(max_iter + 1, N);
[~, tmp]= max(Y);
max_idx(1, :) = tmp;
sums(1, :) = sum(Y);
for t = 1:max_iter
    fprintf('Iter %d: Updating Z...\n', t);
    Z = zeros(k, N);
    parfor j = 1:k
        z_funObj = @(a)z_loss(Vm, a, Y(j, :)');
        z_l1_0 = zeros(num_eigs, 1);
        z_l1 = L1General2_BBST(z_funObj, z_l1_0, z_l1_weight, options);
        Z(j, :) = (Vm * z_l1)';
    end
    Z(Z < EPS) = 0;

    fprintf('Iter %d: Updating Y...\n', t);
    Y = zeros(k, N);
    parfor j = 1:N
        y_funObj = @(y)y_loss(Y0(:, j), Z(:, j), y);
        y_l1_0 = zeros(k, 1);
        y_l1 = L1General2_BBST(y_funObj, y_l1_0, y_l1_weight, options);
        Y(:, j) = y_l1 + Y0(:, j);
    end
    Y(Y < 0) = 0;
    save_path = sprintf('/data3/nanyi_fei/sigir19/data/Y%d.mat', t);
    save(save_path, 'Y');
    
    [~, tmp]= max(Y);
    max_idx(t + 1, :) = tmp;
    sums(t + 1, :) = sum(Y);
end




