clc
clear all
sigma = 0.5;
yi = [+0.2 +0.2 -0.9 +0.6 +0.5 -1.1 -0.4 -1.2];
%yi = [+0.9, -0.2, 0.9, +0.9, +0.9, 1.5, -0.7, 1.2];
%yi = [-0.9, 1.2, -0.9, -0.9, +1.2, 1.5, -0.7, -1.2];
%% Received symbol values
%y0 = +0.2;
%y1 = +0.2;
%y2 = -0.9;
%y3 = +0.6;
%y4 = +0.5;
%y5 = -1.1;
%y6 = -0.4;
%y7 = -1.2;

y0 = yi(1);
y1 = yi(2);
y2 = yi(3);
y3 = yi(4);
y4 = yi(5);
y5 = yi(6);
y6 = yi(7);
y7 = yi(8);

%% Initialization
lq_00 = 2*y0/sigma;
lq_02 = 2*y0/sigma;
lq_10 = 2*y1/sigma;
lq_13 = 2*y1/sigma;
lq_20 = 2*y2/sigma;
lq_31 = 2*y3/sigma;
lq_32 = 2*y3/sigma;
lq_41 = 2*y4/sigma;
lq_43 = 2*y4/sigma;
lq_51 = 2*y5/sigma;
lq_62 = 2*y6/sigma;
lq_73 = 2*y7/sigma;

lx_0  = 2*y0/sigma;
lx_1  = 2*y1/sigma;
lx_2  = 2*y2/sigma;
lx_3  = 2*y3/sigma;
lx_4  = 2*y4/sigma;
lx_5  = 2*y5/sigma;
lx_6  = 2*y6/sigma;
lx_7  = 2*y7/sigma;

for i = 1:1:50
    %% Passing information from check nodes to bit nodes
    lr_00 = funct(lq_10,lq_20);
    lr_01 = funct(lq_00,lq_20);
    lr_02 = funct(lq_00,lq_10);
    lr_13 = funct(lq_41,lq_51);
    lr_14 = funct(lq_31,lq_51);
    lr_15 = funct(lq_31,lq_41);
    lr_20 = funct(lq_32,lq_62);
    lr_23 = funct(lq_02,lq_62);
    lr_26 = funct(lq_02,lq_32);
    lr_31 = funct(lq_43,lq_73);
    lr_34 = funct(lq_13,lq_73);
    lr_37 = funct(lq_13,lq_43);
    
    %% Passing information from bit nodes to check nodes
    lq_00 = lx_0 + lr_20;
    lq_02 = lx_0 + lr_00;
    lq_10 = lx_1 + lr_31;
    lq_13 = lx_1 + lr_01;
    lq_20 = lx_2;
    lq_31 = lx_3 + lr_23;
    lq_32 = lx_3 + lr_13;
    lq_41 = lx_4 + lr_34;
    lq_43 = lx_4 + lr_14;
    lq_51 = lx_5;
    lq_62 = lx_6;
    lq_73 = lx_7;
    
    %% Computing the log-APP ratios for each bit
    lq_0 = lx_0 + lr_00 + lr_20;
    lq_1 = lx_1 + lr_01 + lr_31;
    lq_2 = lx_2 + lr_02;
    lq_3 = lx_3 + lr_13 + lr_23;
    lq_4 = lx_4 + lr_14 + lr_34;
    lq_5 = lx_5 + lr_15;
    lq_6 = lx_6 + lr_26;
    lq_7 = lx_7 + lr_37;
    
    fprintf('Iteration : %d \n',i)
    fprintf('L(Q)\n')
    [lq_0 lq_1 lq_2 lq_3 lq_4 lq_5 lq_6 lq_7]
    fprintf('Codewords\n')
    [slice(lq_0) slice(lq_1) slice(lq_2) slice(lq_3) slice(lq_4) slice(lq_5) slice(lq_6) slice(lq_7)]
end