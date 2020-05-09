function [f, g, h] = z_loss(Vm, a, y)

item = Vm * a - y;
f = item' * item;
g = 2 * Vm' * item;
h = 2 * Vm' * Vm;

end