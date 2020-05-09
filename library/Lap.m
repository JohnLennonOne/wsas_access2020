%%%%%% explanation %%%%%%
% ||Y - Z||_F + lambda1 * ||B * Z'||_1 + lambda2 * ||Y - Y0||_1
%
% L = I - W;
% W = Z_hat * Z_hat' = V * Sigma ^ 2 * V';
% Z_hat = V * Sigma * U';
% Z_hat' * Z_hat = U * Sigma ^ 2 * U';
%
% 1. X: d * N
% 2. Y0: K * N
% 3. fea: N * d
% 4. C: k * d
% 5. I: N * r
% 6. Z: N * k
%%%%%% explanation %%%%%%
% parameters: num_eigs, sigma, k, r
function [S, Vm] = Lap(fea, num_eigs, sigma)

% addpath('/data3/nanyi_fei/nus-wide');
k = 1000;
r = 10;

[~, C] = kmeans(fea, k); % Warning: Failed to converge in 100 iterations.
[~, I] = pdist2(C, fea, 'euclidean', 'Smallest', r);
I = I';
% save('~/Desktop/sigir19/data/C.mat', 'C');
% save('~/Desktop/sigir19/data/I.mat', 'I');
% load('~/Desktop/sigir19/data/C.mat');
% load('~/Desktop/sigir19/data/I.mat');
N = size(I, 1);

% calculating Z
Z = zeros(N, k);
z_numerator = zeros(size(I));
for i = 1:N
    tmp = pdist2(fea(i, :), C(I(i, :), :), 'squaredeuclidean');
    z_numerator(i, :) = exp(tmp ./ (-2 * sigma ^ 2));
end
z_denominator = sum(z_numerator, 2);
for i = 1:N
    for j = 1:r
        Z(i, I(i, j)) = z_numerator(i, j) / z_denominator(i);
    end
end
% save('/data3/nanyi_fei/nus-wide/Z.mat', 'Z');
% load('Z.mat');

% Calculating 
D_Z = sum(Z);
Z_hat = Z * diag(1 ./ sqrt(D_Z));
Z_hatT_mul_Z_hat = sparse(Z_hat' * Z_hat);
[~, S, U] = svds(Z_hatT_mul_Z_hat, num_eigs+1);
S = diag(S);
Vm = Z_hat * U * diag(1 ./ sqrt(S));
Vm = Vm(:, 2:num_eigs+1);
S = 1 - S;
S = sqrt(S(2:num_eigs+1));

end


