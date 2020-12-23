%------------------------------------------------------------
%
% Author : Pratik Shah
% Date : February 25, 2020
% Demo exercise: CS308 Introduction to AI
%
% Markov Random Field for Image Segmentation
%
%-------------------------------------------------------------

clear all;
close all;

%I = imread("noisy_checkerboard_mrf.jpg");
%[M,N] = size(I);

M = 100; N=100;
I(1:100,1:50) = 150+30*randn(100,50);
I(1:100,51:100) = 50 + 30*randn(100,50);

I = [I; I'];
[M,N]=size(I);

S11 = 1:10; S12 = 1:10;
S21 = 90:100; S22 = 90:100;

C1 = I(S11,S12); % class label 1
C2 = I(S21,S22); % class label 2

m(1) = mean(C1(:));
m(2) = mean(C2(:));
s(1) = std(C1(:));
s(2) = std(C2(:));

beta = -100;

% initialize a random assignment of labels {1,2}

%x = 1 + round(rand(M,N));
x1 = abs(I-m(1)); x2 = abs(I-m(2));
x12 = x1-x2;
x12(x12>=0) = 2;
x12(x12<0) = 1;

x = x12;
x(S11,S12) = 1; x(S21,S22)=2; % Known labels

iter_max = 100000;
T = 10000;
for i = 1:iter_max
 l = randperm(M,1); 
 n = randperm(N,1);
 if l==1
	l=2;
 elseif l==M
	l=M-1;
 end
 if n==1
	n=2;
 elseif n==N
	n=N-1;
 end
% if i==1
 xnew = x;  
 Uoldsingle = log(sqrt(2*pi*s(xnew(l,n)).^2))+(I(l,n)-m(xnew(l,n)))./(2*s(xnew(l,n)).^2);
 Uolddouble = beta*((1-2*abs(xnew(l,n)-xnew(l-1,n)))+(1-2*abs(xnew(l,n)-xnew(l,n-1)))+(1-2*abs(xnew(l+1,n)-xnew(l,n)))+(1-2*abs(xnew(l,n+1)-xnew(l,n))));
 Uold = Uoldsingle+Uolddouble;
% end

 xnew(l,n) = 1+mod(xnew(l,n),2);

 Unewsingle = log(sqrt(2*pi*s(xnew(l,n)).^2))+(I(l,n)-m(xnew(l,n)))./(2*s(xnew(l,n)).^2);
 Unewdouble = beta*((1-2*abs(xnew(l,n)-xnew(l-1,n)))+(1-2*abs(xnew(l,n)-xnew(l,n-1)))+(1-2*abs(xnew(l+1,n)-xnew(l,n)))+(1-2*abs(xnew(l,n+1)-xnew(l,n))));
 Unew = Unewsingle+Unewdouble;
 
 deltaU = Unew-Uold;
 if deltaU <= 0
  x = xnew; Uold=Unew;
 else
  if rand < exp(-deltaU/T)
   x = xnew; Uold=Unew;
  end
 end
 T = (T+i)/i;
 x(S11,S12) = 1; x(S21,S22)=2;
end

figure(1); hold on;
subplot(2,2,1); imshow(uint8(I)); hold on;
subplot(2,2,3); imshow(2-x12); hold on;
subplot(2,2,4); imshow(2-x);
