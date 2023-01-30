%%%data preparation 
function train_X1=construction(img1,PS)
[M,N] = size(img1);
switch PS
    case 1
        % % %%%%%1*1window
        train_X1=reshape(img1,M*N,1);
    case 3
        train_X=zeros(M,N,9);%%%neibourhood size 3*3
        row1=[0 img1(1,:) 0];
        row2=[0 img1(M,:) 0];
        col1=img1(:,1);
        col2=img1(:,N);
        temp_img1=[row1;col1,img1,col2;row2];
        for i=2:M+1
            for j=2:N+1  
               train_X_temp=temp_img1(i-1:i+1,j-1:j+1);
               train_X(i-1,j-1,:)=train_X_temp(:);
            end
        end  
        [M1,N1,Y] = size(train_X);
        train_X1=reshape(train_X,M1*N1,9);
    case 5
        train_X=zeros(M,N,25);%%%neibourhood size 5*5
        row1=[0 0 img1(1,:) 0 0;0 0 img1(2,:) 0 0];
        row2=[0 0 img1(M-1,:) 0 0;0 0 img1(M,:) 0 0];
        col1=img1(:,1:2);
        col2=img1(:,N-1:N);
        temp_img1=[row1;col1,img1,col2;row2];
        for i=3:M+2
            for j=3:N+2  
               train_X_temp=temp_img1(i-2:i+2,j-2:j+2);
               train_X(i-2,j-2,:)=train_X_temp(:);
            end
        end  
        [M1,N1,Y] = size(train_X);
        train_X1=reshape(train_X,M1*N1,25);
    case 7
        train_X=zeros(M,N,49);%%%neibourhood size 7*7 
        row1=[0 0 0 img1(1,:) 0 0 0;0 0 0 img1(2,:) 0 0 0;0 0 0 img1(3,:) 0 0 0];
        row2=[0 0 0 img1(M-2,:) 0 0 0;0 0 0 img1(M-1,:) 0 0 0;0 0 0 img1(M,:) 0 0 0];
        col1=img1(:,1:3);
        col2=img1(:,N-2:N);
        temp_img1=[row1;col1,img1,col2;row2];
        for i=4:M+3
            for j=4:N+3  
               train_X_temp=temp_img1(i-3:i+3,j-3:j+3);
               train_X(i-3,j-3,:)=train_X_temp(:);
            end
        end  
        [M1,N1,Y] = size(train_X);
        train_X1=reshape(train_X,M1*N1,49);
end
% train_X1=mapminmax(train_X1',0,1)';
% train_X1=(train_X1-min(min(train_X1)))/(max(max(train_X1))-min(min(train_X1)));