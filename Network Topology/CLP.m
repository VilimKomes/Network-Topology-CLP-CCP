function [Kro,res]=CLP(p,beta,K)

% K has to be increased in order to solve for K
K=K+1;
% broj cvorova
N=length(p);

% Aeq, beq
beq=ones(N,1);
Aeq=zeros(N,N^2+N);

for i=1:N
    for j=1:N
        Aeq(i,f_index(i,j,N))=1;
    end
end


% A,b
b=zeros(N,1);
A=zeros(N,N^2+N);

% first N^2 elements
for row=1:N
    x=row;
    for i=1:N
        if i==1
            A(row,x)=1;
        else
            A(row,x+N)=1;
            x=x+N;
        end
    end
end
% last N elements (y is -K because Ax<=b while we have Ax<=Cy so Ax-Cy<=0)
for j=N^2+1:N^2+N
    for i=1:N
        if j-N^2==i
            A(i,j)=-K;
        else
            A(i,j)=0;
        end

    end
end


%funkcija cilja
c = 10*ones(1,N^2+N);
ite=1;
for i=1:N
    for j=1:N
        if i==j
            c(ite)=0; 
            ite=ite+1;
        end
        if i~=j
            c(ite)=sqrt((p(i)-p(j)).^2+(p(i+N)-p(j+N)).^2);
            ite=ite+1;
        end
    end
end
ite=1;
for i=(N^2)+1:N^2+N
    c(i)=beta(ite);
    ite=ite+1;
end

lb=zeros(1,N^2+N);
ub=ones(1,N^2+N)*inf;
for i=N^2+1:N^2+N
    ub(i)=1;
end

INTS=1:1:N^2+N;

res=intlinprog(c,INTS,A,b,Aeq,beq,lb,ub);
koncetratori=res(length(res)-length(beta)+1:length(res));
disp("Concentrator coordinates");
Kro=zeros(1, 2);
cnt=1;
for i=1:N
    if koncetratori(i)==1
        disp(p(i,:));
        Kro(cnt, :) = p(i,:);
        cnt=cnt+1;
    end
end
disp("Adjacencdy matrix")
disp(ToMatrix(res(1:length(res)-length(beta))).');
disp("Concentrators")
disp(res(length(res)-length(beta)+1:length(res)));
