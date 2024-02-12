# Network-Topology-CLP-CCP
Program for choosing concetrators and connecting them into 2-vertex connceted graph

CLP
Minimizes the goal function of creating a concentrator from a vertex (beta) and connecting vertex i to vertex j by alpha_ij which is the distance between them.
Every vertex has to be connected to a concentrator and the number of vertices connected to a conncetrator K, cant be exceeded. 

CCP 
Connects concentrators into a 2-vertex undirected graph with a starting necessary condition that every connecntrator has to have at least k=2 edges connected to it
then adding sufficient conditions (for every subset S of K concentrators there have to be at least edges going to the compliment of S, S^c) so that the graph can be 2-vertex connected.
If k>2 then the graph will still be 2-vertex connected because the implementaion uses biconncomp but the amount of edges is gonna be increased to 3 which will add to the reliability of the network.

CLP
Examples: 
Creating random coordinates and choosing concentrators from the set of 50 vertices 
              N,range,option,K_k,beta_b,custom_coordinates,k

[c,N]=CreateCoordinates(50,75,1,4,50,[],0)

c are the coordinates of chosen concentrators and N are the cordinates of all random vertices
50 vertices, with range of (x,y) [0,75], option 1 is CLP, K=4 amount of terminals that can be connected to one concentrator, [] empty set of coordinates,beta=50 ,k=0 (used in CCP)
(NOTE: empty set can be replaced by custom coordinates e.g. co=[1 2; 3 5; 6 7] the added to function CreateCoordinates(3,7,1,4,50,c,0))


CCP
Examples:
CreateCoordinates(20,75,2,0,0,[],2)
or 
CreateCoordinates(3,7,2,0,0,co,2)
