clear all
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
dlmwrite ("coeff.txt", b,'delimiter','\n');

lpFilter = dsp.FIRFilter('Numerator',b);

lpFilter.CoefficientsDataType='Custom';
lpFilter.CustomCoefficientsDataType=numerictype(1,14,13);
lpFilter.OutputDataType='Same as Accumulator';
lpFilter.ProductDataType='Full precision';
lpFilter.AccumulatorDataType='Full precision';

x = chirp(0:199,0,199,0.4);

lpcoeffs = lpFilter.Numerator;            % store original lowpass coefficients
y1 = lpFilter(fi(x,1,14,13).');           % filter the signal


lpFilter.Numerator = lpcoeffs;            % restore original lowpass coefficients

figure
plot(y1,x);
xlabel('Time [samples]');ylabel('Amplitude'); title('Input Stimulus');
