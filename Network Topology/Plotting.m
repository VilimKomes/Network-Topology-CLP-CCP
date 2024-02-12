function Plotting(p_,coordinates,range,option)

x=coordinates(:,1);
y=coordinates(:,2);
if(length(p_)>length(coordinates))
    p=ToMatrix(p_);
else
    p=p_;
end
ite=1;
if(option==1)
    for j=1:length(p)
        q=p(:,j);
        for i=1:length(q)
            if(q(i)==1)
                s(ite)=i;
                t(ite)=j;
                ite=ite+1;
            end
        end
    end
    plot(graph(s,t),'-dr','XData',x,'YData',y)
    xlim([-3 range+3]);
    ylim([-3,range+3]);
end
if(option==2)
    N=length(p);
    for j=1:N
        q=p(:,j);
        for i=1:N
            if(q(i)==1)
                p(j,i)=0;
            end
        end
    end
    for j=1:length(p)
        q=p(:,j);
        for i=1:length(q)
            if(q(i)==1)
                t(ite)=i;
                s(ite)=j;
                ite=ite+1;
            end
        end
    end
    plot(graph(s,t),'-db','XData',x,'YData',y)
    xlim([-3 range+3]);
    ylim([-3,range+3]);
end