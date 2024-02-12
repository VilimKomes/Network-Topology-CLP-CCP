function res=CCP(p,k)
% works for 2-vertex connected graphs because bicconected method is implemented
% Number of conncetrators
N=length(p);


% aij=aji or aij-aji=0;
Aeq=zeros((N*(N-1))/2,N*N);
beq=zeros((N*(N-1))/2,1);
ite=1;
for i=1:N
    for j=i:N
        if(i~=j)
            Aeq(ite,f_index(i,j,N))=1;
            Aeq(ite,f_index(j,i,N))=-1;
            ite=ite+1;
        end
    end
end

% distance between (cost) /  gamma
d=zeros(1,N^2);
for i=1:N
    for j=1:N
        index=f_index(i,j,N);
        d(index)=sqrt((p(i)-p(j)).^2+((p(i+N)-p(j+N)).^2));
    end
end

% A
% neccessary condition
A=zeros(1,N*N);

for i=1:N
    for j=1:N
        if(i~=j)
            A(i,f_index(i,j,N))=1;
        end
    end
end

% Zijhas to be 0 or 1
lb=zeros(1,N^2);
ub=ones(1,N^2);
INTS=1:1:N^2;
M=size(A);

% with k>2 we can incersase reliability of network (Check with realiability polynomial)
b=k*ones(M(1),1);
vertices=1:N;
prolaz=1;
while(true)
    disp("prolaz "+prolaz);
    prolaz=prolaz+1;
    res=intlinprog(d,INTS,-A,-b,Aeq,beq,lb,ub);
    p_=ToMatrix(res);
    ite=1;
    for j=1:N
        q=p_(:,j);
        for i=1:N
            if(q(i)==1)
                p_(j,i)=0;
            end
        end
    end
    for j=1:length(p_)
        q=p_(:,j);
        for i=1:length(q)
            if(q(i)==1)
                t(ite)=i;
                s(ite)=j;
                ite=ite+1;
            end
        end
    end
    G=graph(s,t);
    [edgebins,~]=biconncomp(G);
    if max(edgebins)>1
        % sorting the components
        Components=zeros(max(edgebins),length(edgebins));
        ite_2=ones(1,max(edgebins));
        for i=1:length(edgebins)
            if(ismember(s(i),Components(edgebins(i),:))==0)
                Components(edgebins(i),ite_2(edgebins(i)))=s(i);
                ite_2(edgebins(i))=ite_2(edgebins(i))+1;
            end
            if(ismember(t(i),Components(edgebins(i),:))==0)
                Components(edgebins(i),ite_2(edgebins(i)))=t(i);
                ite_2(edgebins(i))=ite_2(edgebins(i))+1;
            end
        end
        % adding extra condtions
        extraRows=size(A);
        extraRows=extraRows(1);
        for i=1:max(edgebins)
            S=nonzeros(Components(i,:));
            S=S';
            notS=setdiff(vertices,S);
            b=[b;2];
            extraRows=extraRows+1;
            for j=1:length(S)
                for z=1:length(notS)
                    A(extraRows,f_index(S(j),notS(z),N))=1;
                end
                
            end
        end
    else
        break;
    end
end

disp("adjency matrix")
disp(ToMatrix(res))
