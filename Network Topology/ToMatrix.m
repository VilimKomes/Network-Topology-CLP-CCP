function res=ToMatrix(D)

N=sqrt(length(D));
M=zeros(N,N);
for i=1:length(D)
    M(i)=D(i);
end

M=M.';
res=M;