function yout = prediction(x1,x2,x3,x4,x5,x6,x7,x8,x9)
global theta
Xin = [1,x2,x3,x4,x5,x6,x7,x8,x9];
t = theta{x1};
yout = Xin*t;