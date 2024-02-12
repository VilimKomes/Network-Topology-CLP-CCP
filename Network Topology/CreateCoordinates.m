function [Kro,V,res]=CreateCoordinates(N,range,option,K_k,beta_b,custom_coordinates,k)

if(isempty(custom_coordinates))
    coordinates = zeros(N, 2); 
    for i = 1:N
        x = randperm(range, 1);
        y = randperm(range, 1);
        % check for duplicates
        while any(all(coordinates == [x, y], 2))
            x = randperm(range, 1);
            y = randperm(range, 1);
        end
    coordinates(i, :) = [x, y];
    end
else
    range=max(max(custom_coordinates));
    N=length(custom_coordinates);
    coordinates=custom_coordinates;
end
disp("Vertex coordinates");
disp(coordinates);

if(option==1)
    beta=beta_b*ones(1,length(coordinates));
    K=K_k;
    V=coordinates;
    [Kro,res]=CLP(coordinates,beta,K);
    matrica_povezanosti=res(1:length(res)-length(beta));
    Plotting(matrica_povezanosti,coordinates,range,1)
elseif(option==2)
    res=CCP(coordinates,k);
    Plotting(res,coordinates,range,2);
else
    disp("wrong input [1,0]")
end
