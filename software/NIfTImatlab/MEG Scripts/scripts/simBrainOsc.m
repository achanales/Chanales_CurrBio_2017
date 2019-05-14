t  = [ 0 : 1 : 100000];           % Time Samples
f  = 4;                       % Input Signal Frequency
Fs = 44100;                     % Sampling Frequency
data = sin(2*pi*f/Fs*t)';
% Generate Sine Wave

for ishift = 201:100:100000
    
data(ishift)=mean(data(ishift-200:ishift))+randn(1)*lowerdata(ishift);  
plotdata = data(1:ishift);
    
plot(t(1:ishift),plotdata)
axis([0 100000 -5 5 ])
pause(.001)
clf


end

t  = [ 0 : 1 : 100000];           % Time Samples
f  = .25;                       % Input Signal Frequency
Fs = 44100;                     % Sampling Frequency
lowerdata = sin(2*pi*f/Fs*t)';


for ishift = 101:100:1000000
lowerdata(ishift)=mean(lowerdata(ishift-10:ishift));  
plotdata = lowerdata(1:ishift);
    
plot(t(1:ishift),plotdata)
axis([0 100000 -3 3 ])
pause(.001)
clf


end


t  = [ 0 : 1 : 100000];           % Time Samples
f  = 4;                       % Input Signal Frequency
Fs = 44100;                     % Sampling Frequency
data = sin(2*pi*f/Fs*t)'.*3;
% Generate Sine Wave

for ishift = 201:100:100000
shift_idx = 1;   
data(ishift)=mean(data(ishift-200:ishift))+randn(1)*.1;  
plotdata = data(1:ishift);
    
plot(t(1:ishift),plotdata);
axis([0 100000 -5 5 ])
axis off
simMovie(shift_idx) = getframe;
pause(.01)
shift_idx = shift_idx + 1;
clf
end

movie(simMovie)

t  = [ 0 : 1 : 100000];           % Time Samples
f  = 4;                       % Input Signal Frequency
Fs = 44100;                     % Sampling Frequency
data = sin(2*pi*f/Fs*t)'.*3;
% Generate Sine Wave

for ishift = 201:100:100000
    
data(ishift)=mean(data(ishift-200:ishift))+randn(1)*lowerdata(ishift);  
plotdata = data(1:ishift);
    
plot(t(1:ishift),plotdata)
axis([0 100000 -5 5 ])
pause(.001)
clf


end

t  = [ 0 : 1 : 100000];           % Time Samples
f  = 4;                       % Input Signal Frequency
Fs = 44100;                     % Sampling Frequency
data = sin(2*pi*f/Fs*t)'.*3;
% Generate Sine Wave

for ishift = 201:100:100000
    
data(ishift)=mean(data(ishift-200:ishift))+randn(1)*3*lowerdata(ishift);  
plotdata = data(1:ishift);
    
plot(t(1:ishift),plotdata)
axis([0 100000 -5 5 ])
pause(.001)
clf


end