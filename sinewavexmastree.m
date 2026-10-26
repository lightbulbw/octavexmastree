%making a xmas tree out of sine waves
%fourrier series are a sum of sine waves to make a shape
%adding the right sine waves you can make any shape
%however how do you find the right sine waves?
%its easier to take a known fourrier series and then modify it
%here we will use a triangle wave fourrier series 
%because the most basic xmas tree is a triangle
%and then we modify this triangle to get branches 
%(aka we constrain waves into a triangle shape)
%and we force it to be constant at the bottom to have a square trunk


1;%put this to tell octave this is a script and not a function declaration file
function w = cone(y)
  %remap pi/2 to 0-1 and flip direction with 1-y
  x=(pi/2)*(1-y);
  %fourrier series of triangle wave
  w=zeros(size(x));
  for n = 1:2:100 %start at 1(first harmonic), steps of 2(so odd harmonics only),last harmonic
    w+=((-1)^((n-1)/2))*sin(n*x)/n^2;
  endfor
  %normalization
  w*=8/pi^2; %1.0 at base->0.0 at apex
endfunction

%------main-----------
N=100;%resolution(the bigger the smoother the rendered shaoe will be)
%make a row vector of n evenly spaced points between(and including) 0 and 1, .' makes row into col
y=linspace(0, 1, N).';%column vector, 0=ground, 1=treetop

w=cone(y);%make a triangle

%to have separete branches
%put waves into the triangle which makes the branches
%. means elemtwise operation
%w.*=1+0.2*cos(9*pi*y);
%w.*=2+0.2*cos(19*pi*y);
%w.*=1+0.2*cos(19*pi*y);
w.*=0.5+0.2*cos(9*pi*y);

%trunk:at bottom make w=0.075 so bottom looks like a square
wt=w;
wt(y<0.08)=0.075;

%-----plot-------------
figure(1);
hold on;
plot(wt, y); %plot half
plot(-wt, y); %plot other half
%fill inner boundary of tree
xfill=[-wt;flipud(wt)];
yfill=[y;flipud(y)];
fill(xfill,yfill,[0.13 0.55 0.13]);









