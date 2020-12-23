function [suc] = successor(node)
 xmin = 1; ymin = 1; xmax = 100; ymax = 100;

suc=[];

if node(1,2)==1
 l = [0,1];
elseif node(1,2)==xmax
 l = [-1,0];
else
 l = [-1,0,1];
end

if node(1,3)==1
 m = [0,1];
elseif node(1,3)==xmax
 m = [-1,0];
else
 m = [-1,0,1];
end

for i=1:length(l)
 for j=1:length(m)
  suc = [suc; node(1,2)+l(i) node(1,3)+m(j)];
 end
end

[sId] = find(suc(:,1)==node(1,2) & suc(:,2)==node(1,3));
if(~isempty(sId))
 suc(sId,:)=[];
end

end

