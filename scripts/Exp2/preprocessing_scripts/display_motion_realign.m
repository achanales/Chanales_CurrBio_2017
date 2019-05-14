%rp = spm_load('rscan01.txt'); %select the rp*.txt file
rp = textscan(fopen('rscan01.par'),'%n%n%n%n%n%n');
figure;
subplot(2,1,1);plot(rp(:,1:3));
set(gca,'xlim',[0 size(rp,1)+1]);
subplot(2,1,2);plot(rp(:,4:6));
set(gca,'xlim',[0 size(rp,1)+1]);