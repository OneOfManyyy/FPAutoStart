clear all
format long

%order of the filter
n = 150;
%transition Frequencies
f = [0 .4 1];
%amplitudes
a = [1 0];
%upper and lower Freq response
up = [1.02 0.01];
lo = [0.98 -0.01];

b = fircls(n, f, a, up, lo, 'both');
writematrix (b, "coeff_integer.txt");

% we want to change the format from decimal to (1,31,32) binary

factor = 2^32; % the number fractional bits

b_factor = b * factor;

b_bin = dec2bin (b_factor, 64);

writematrix (b_bin, "coeff_binary.txt");

