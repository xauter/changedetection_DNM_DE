function O=my_DNM(data,net)
M = net.M;
qs = net.qs;
k = net.k;
ks = net.ks;
w = net.w;
q = net.q;

P=data';
[I,J]=size(P); % I is the dimension of samples; J is the number of sample.
Y=zeros(I,M,J);
Z=ones(M,J);
V=zeros(J,1);
O=zeros(J,1);
Q=zeros(J,1);

for j=1:J
for m=1:M
    for i=1:I
        Y(i,m,j)=max(0,k*(w(i,m)*P(i,j)-q(i,m)));
    end
end
% build a AND layer
for m=1:M
   Q=0;                  
    for i=1:I           
         Q=Q+Y(i,m,j);
    end                
    Z(m,j)=Q/I;
end
     
% build a OR layer
V=sum(Z);
% build a soma layer
O(j)=max(0,ks*(V(j)-qs));
end





