function [suc] = successor1(node)
 xmin = 1; ymin = 1; xmax = 100; ymax = 100;

suc=[];

if node(1,2)==1
 if node(1,3)==1
  s=[1 0;0 1];
 elseif node(1,3)==ymax
  s=[0 -1;1 0];
 else
  s = [0 -1;0 1;1 0];
 end
elseif node(1,2)==xmax
 if node(1,3)==1
  s = [-1 0;0 1];
 elseif node(1,3)==ymax
  s = [-1 0;0 -1];
 else
  s = [0 -1;0 1;-1 0];
 end
else
 if node(1,3)==1
  s = [-1 0;1 0;0 1];
 elseif node(1,3)==ymax
  s = [-1 0;1 0;0 -1];
 else
  s = [-1 0;1 0;0 -1;0 1];
 end
end

suc = node(1,2:3)+s;

end


