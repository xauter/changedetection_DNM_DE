function [data,hd]=getdata(xlsfile)
% [data,hd]=getdata('cleveland.xls')
% read age,sex,cp,trestbps,chol,fbs,restecg,thalach,exang,oldpeak,slope,ca,thal,hd from a xls file

[hd,~]=xlsread(xlsfile,'N2:N298');
[age,~]=xlsread(xlsfile,'A2:A298');
[sex,~]=xlsread(xlsfile,'B2:B298');
[cp,~]=xlsread(xlsfile,'C2:C298');
[trestbps,~]=xlsread(xlsfile,'D2:D298');
[chol,~]=xlsread(xlsfile,'E2:E298');
[fbs,~]=xlsread(xlsfile,'F2:F298');
[restecg,~]=xlsread(xlsfile,'G2:G298');
[thalach,~]=xlsread(xlsfile,'H2:H298');
[exang,~]=xlsread(xlsfile,'I2:I298');
[oldpeak,~]=xlsread(xlsfile,'J2:J298');
[slope,~]=xlsread(xlsfile,'K2:K298');
[ca,~]=xlsread(xlsfile,'L2:L298');
[thal,~]=xlsread(xlsfile,'M2:M298');

data=[age,sex,cp,trestbps,chol,fbs,restecg,thalach,exang,oldpeak,slope,ca,thal];
hd=[hd];
