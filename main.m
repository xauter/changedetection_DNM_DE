close all
clear all

format long;
format compact;

%%%data preparation 
img1=imread('1.bmp');
img2=imread('2.bmp');
Lab_Ref=imread('3.bmp');
Lab_Ref=double(Lab_Ref(:,:,1)/255);
im1 = double(img1(:,:,1));
im2 = double(img2(:,:,1));
[im_M,im_N] = size(img1(:,:,1));
PS=3%%%%%%%%%%%%patch size

im_di = di_gen(im1, im2);%%%difference image generation
pixel_vector = reshape(im_di, im_M*im_N, 1);

fprintf('... ... clustering begin ... ...\n');
im_lab = hclustering(pixel_vector, im_di);
fprintf('@@@ @@@ clustering finished @@@@\n');
im_lab=1-im_lab;

Lab_all=reshape(im_lab,im_M*im_N,1);%%%%%unsupervised label
clear pixel_vector;

fprintf(' ... ... ... samples initializaton begin ... ... .....\n');

pos_idx = find(im_lab == 1);
neg_idx = find(im_lab == 0);
tst_idx = find(im_lab == 0.5);

%%%%quantity of training samples labeled 0 or 1(less one) the fianl quantity is 2*kk
if length(neg_idx) < length(pos_idx)
    kk= length(neg_idx);
else
    kk= length(pos_idx);
end

train_x2=construction(im_di,PS);
train_all=mapminmax(train_x2',0,1)';

%%%%%%%%%%%%%%%train_all shape: number of samples *attributes

kkc = randi(length(pos_idx),1,kk);
kku = randi(length(neg_idx),1,kk);
kk1=[pos_idx(kkc);neg_idx(kku)];

tic;
train_data=train_all(kk1,:);%%%%training set
train_target=Lab_all(kk1,:);%%%training sample label
[I,J] = size(train_data);

%% Hyper-parameters and The parameter of DE
M = 10
popsize = 100; % the size of population
D = J * M * 2+3; % the dimension of sample
F = 0.5; % scaling factor
CR = 0.9; % crossover rate
iter = 10;

%% parameter structure 
Parameter.F = F;
Parameter.CR = CR;
Parameter.popsize = popsize;
Parameter.D = D;
Parameter.iter = iter;
net.M = M;

%% train
[w,q,k,qs,ks,best] =train(Parameter,net,train_data,train_target);
net.w = w;
net.q = q;
net.qs = qs;
net.k = k;
net.ks = ks;
%% test
%%%%%%%%%%%%%%%%%%%

error = best;%%%%error record
test_data = train_all;

test_fit=my_DNM(test_data,net);
DiffMap= reshape(test_fit,im_M,im_N);
% figure();
% imshow(DiffMap);

for i = 1:im_M*im_N
    if test_fit(i) >= 0.5
        test_fit1(i) = 1;
    else
        test_fit1(i) = 0;
    end  
end
test_fit1 = reshape(test_fit1,im_M,im_N);
% === refine the results =============
nos_th = 10;
[res_lab,num] = bwlabel(test_fit1);
for i = 1:num
    idx = find(res_lab==i);
    if numel(idx) <= nos_th
        res_lab(idx)=0;
    end
end
res_lab = res_lab>0;

[res_lab,num] = bwlabel(~res_lab);
for i = 1:num
    idx = find(res_lab==i);
    if numel(idx) <= nos_th
        res_lab(idx)=0;
    end
end
ChangeMap = ~(res_lab>0);

figure();
imshow(ChangeMap);
toc;

