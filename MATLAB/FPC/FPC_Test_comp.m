clear
format long
inp = 0:.01:pi;
out = FPC_Test (inp);
out_fi = FPC_Test_fixpt (inp);

R = out_fi - out

plot (inp, out_fi, inp, out)