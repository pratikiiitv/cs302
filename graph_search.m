% ----------------------------------------------
% Author : Pratik Shah
% Date : May 2, 2020
% Place: Gandhinagar
%
% Hands-on Session Exercise/ Demo
% FDP on Artificial Intelligence
% 11-15 May, 2020
%
% Breadth/Depth First Search, Uniform Cost Search
% Best First Search/ Hill Climbing
% A* Search
% ----------------------------------------------

clear all;
close all;

I = imread('search_map2.png');

InitState = [1,1];
GoalState = [100,100];
%I = 255*ones(100,100);
%InitState = [25 25];
%GoalState = [70 80];

figure(1);
subplot(1,2,1); imshow(I);
I = double(I);

% [1/0 x y xparent yparent g h f]
g = 0; h = norm(InitState-GoalState); f=g+h;
RootNode = [1 InitState 0 0 g h f];
Explored = []; Frontier = [];
Frontier = pushFrontier(RootNode,Frontier);

while (true)
 if(isempty(Frontier)==1)
	display("Goal State not reachable.\n");
	break;
 end
 [Frontier,frontnode] = popFrontier(Frontier);
 GT = GoalTest(frontnode(1,2:3),GoalState);
 if(GT==1)
  display("Goal State Reached.\n");
  break;
 end
 Explored = [frontnode;Explored];
% SuccessorStates = successor1(frontnode); %4 Connected
 SuccessorStates = successor(frontnode); %8 Connected
 [k,k1] = size(SuccessorStates);

 for i=1:k
  [sStateIndex]=find(Frontier(:,2)==SuccessorStates(i,1) & Frontier(:,3)==SuccessorStates(i,2));
  [sStateIndex1]=find(Explored(:,2)==SuccessorStates(i,1) & Explored(:,3)==SuccessorStates(i,2));

  if(isempty(sStateIndex1))
%    g = frontnode(1,6)+1.5+1000*abs(I(frontnode(1,2),frontnode(1,3))-I(SuccessorStates(i,1),SuccessorStates(i,2)));
    g = frontnode(1,6)+norm(frontnode(1,2:3)-SuccessorStates);
    g = g+abs(I(frontnode(1,2),frontnode(1,3))-I(SuccessorStates(i,1),SuccessorStates(i,2))); 	
%    h = 0;
    h = norm(SuccessorStates(i,:)-GoalState); 	
%    h = sum(abs(SuccessorStates(i,:)-GoalState));	
    f = g+h;
   if(isempty(sStateIndex) || f<Frontier(sStateIndex,8))
    SuccessorNode = [1 SuccessorStates(i,:) frontnode(1,2:3) g h f];
    if(~isempty(sStateIndex))
     Frontier(sStateIndex,:) = [];	
    end
    Frontier = pushFrontier(Frontier,SuccessorNode);
   end
  end
 end
% -- Priority Queue -------
 [Fsort,inx] = sort(Frontier(:,8));
 Frontier = Frontier(inx,:);
% -------------------------
end

%------ Just for fun -------------
[r,r1] = size(Explored);
for i = 1:r
   I(Explored(i,2),Explored(i,3))=75;
end


OptPath = [frontnode(1,2) frontnode(1,3);frontnode(1,4) frontnode(1,5)];
state = OptPath(end,:);
I(state(1,1),state(1,2)) = 150;
while(~(state(1,1)==InitState(1,1) & state(1,2)==InitState(1,2)))
 [id] = find(Explored(:,2)==OptPath(end,1) & Explored(:,3)==OptPath(end,2));
 OptPath = [OptPath; Explored(id,4) Explored(id,5)];
 state = OptPath(end,:);
 I(state(1,1),state(1,2)) = 150;
end

subplot(1,2,2);
imshow(uint8(I));



