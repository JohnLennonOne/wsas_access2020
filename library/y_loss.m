function [f, g, h] = y_loss(y0, z, y)

k = size(y0, 1);
item = y + y0 - z;
f = item' * item;
g = 2 * item;
h = 2 * eye(k);

end