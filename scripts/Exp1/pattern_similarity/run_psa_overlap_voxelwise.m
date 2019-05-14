function[dataMat,oMat,noMat,sMat,combMat,srxo,srMat]= run_psa_overlap_voxelwise(all_data,meta_runs_condensed,condensed_regs_all,S)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %   RUN PSA
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    oddruns = mod(meta_runs_condensed,2) == 1; %get index for all odd runs
    evenruns = mod(meta_runs_condensed,2) == 0; %get index for all even runs
    firsthalf = meta_runs_condensed<7; %get index for rusn 1-6
    secondhalf = meta_runs_condensed>8; %get index for rusn 9-14
         
 for route = 1:4
    r_inxh1_o = logical(condensed_regs_all(route,:) & firsthalf & oddruns); %trial indices for the first half odd runs
    r_inxh1_e = logical(condensed_regs_all(route,:) & firsthalf & evenruns); %trial indices for the first half even runs
    r_inxh2_o = logical(condensed_regs_all(route,:) & secondhalf & oddruns); %trial indices for the second half odd runs
    r_inxh2_e = logical(condensed_regs_all(route,:) & secondhalf & evenruns); %trial indices for the second half even runs     

    r_path1_o(:,:,route) = mean(all_data(:,:,r_inxh1_o),3); %tr x voxel pattern first half
    r_path1_e(:,:,route) = mean(all_data(:,:,r_inxh1_e),3); %tr x voxel pattern first half
    r_path2_o(:,:,route) = mean(all_data(:,:,r_inxh2_o),3); %tr x voxel pattern second half
    r_path2_e(:,:,route) = mean(all_data(:,:,r_inxh2_e),3); %tr x voxel pattern second half
 end

%Establish variables
num_vox = size(r_path1_o,2);

sp1_1 = zeros(1,num_vox);
sp1_2 = zeros(1,num_vox);
sp2_1 = zeros(1,num_vox);
sp2_2 = zeros(1,num_vox);
sp3_1 = zeros(1,num_vox);
sp3_2 = zeros(1,num_vox);
sp4_1 = zeros(1,num_vox);
sp4_2 = zeros(1,num_vox);

op1_1 = zeros(1,num_vox);
op2_1 = zeros(1,num_vox);
op1_2 = zeros(1,num_vox);
op2_2 = zeros(1,num_vox);

nop1_1 = zeros(1,num_vox);
nop2_1 = zeros(1,num_vox);
nop1_2 = zeros(1,num_vox);
nop2_2 = zeros(1,num_vox);
nop3_1 = zeros(1,num_vox);
nop3_2 = zeros(1,num_vox);
nop4_1 = zeros(1,num_vox);
nop4_2 = zeros(1,num_vox);

overlap_p1 = zeros(4,4);
overlap_p1(1,2) = 1;
overlap_p1(2,1) = 1; 

overlap_p2 = zeros(4,4);
overlap_p2(3,4) = 1;
overlap_p2(4,3) = 1;

diff_p1 = zeros(4,4);
diff_p1(1,4) = 1;
diff_p1(4,1) = 1;

diff_p2 = zeros(4,4);
diff_p2(2,3) = 1;
diff_p2(3,2) = 1;

diff_p3 = zeros(4,4);
diff_p3(2,4) = 1;
diff_p3(4,2) = 1;

diff_p4 = zeros(4,4);
diff_p4(1,3) = 1;
diff_p4(3,1) = 1;

%Compute timecourse similarity for each voxel across all posibble
%comparison seperately for each half
for i = 1:num_vox
    h1corrmat = corr(squeeze(r_path1_o(:,i,:)),squeeze(r_path1_e(:,i,:)));
    h2corrmat = corr(squeeze(r_path2_o(:,i,:)),squeeze(r_path2_e(:,i,:)));

    h1corrmat = fisherz(h1corrmat);
    h2corrmat = fisherz(h2corrmat);
    
    %overlap pair 1
    op1_1(i) = mean(h1corrmat(find(overlap_p1)));
    op1_2(i) = mean(h2corrmat(find(overlap_p1)));
    
    %overlap pair 2
    op2_1(i) = mean(h1corrmat(find(overlap_p2)));
    op2_2(i) = mean(h2corrmat(find(overlap_p2)));
    
    %same routes
    sp1_1(i) = h1corrmat(1,1);
    sp1_2(i) = h2corrmat(1,1);
    sp2_1(i) = h1corrmat(2,2);
    sp2_2(i) = h2corrmat(2,2);
    sp3_1(i) = h1corrmat(3,3);
    sp3_2(i) = h2corrmat(3,3);
    sp4_1(i) = h1corrmat(4,4);
    sp4_2(i) = h2corrmat(4,4);
    
    %non overlap pair 1
    nop1_1(i) = mean(h1corrmat(find(diff_p1)));
    nop1_2(i) = mean(h2corrmat(find(diff_p1)));
    
    %non overlap pair 2
    nop2_1(i) = mean(h1corrmat(find(diff_p2)));
    nop2_2(i) = mean(h2corrmat(find(diff_p2)));
    
    %non overlap pair 3
    nop3_1(i) = mean(h1corrmat(find(diff_p3)));
    nop3_2(i) = mean(h2corrmat(find(diff_p3)));
    
    %non overlap pair 4
    nop4_1(i) = mean(h1corrmat(find(diff_p4)));
    nop4_2(i) = mean(h2corrmat(find(diff_p4)));
end

%Sort voxels in decedning order based on first half sim
[~,idxo1] = sort(op1_1,'descend');
[~,idxo2] = sort(op2_1,'descend');
[~,idxno1] = sort(nop1_1,'descend');
[~,idxno2] = sort(nop2_1,'descend');
[~,idxno3] = sort(nop3_1,'descend');
[~,idxno4] = sort(nop4_1,'descend');
[~,idxs1] = sort(sp1_1,'descend');
[~,idxs2] = sort(sp2_1,'descend');
[~,idxs3] = sort(sp3_1,'descend');
[~,idxs4] = sort(sp4_1,'descend');

%Rank Voxels
vox_rank_op1 = 1:num_vox;
vox_rank_op1(idxo1) = vox_rank_op1;

vox_rank_op2 = 1:num_vox;
vox_rank_op2(idxo2) = vox_rank_op2;

vox_rank_nop1 = 1:num_vox;
vox_rank_nop1(idxno1) = vox_rank_nop1;

vox_rank_nop2 = 1:num_vox;
vox_rank_nop2(idxno2) = vox_rank_nop2;

vox_rank_nop3 = 1:num_vox;
vox_rank_nop3(idxno3) = vox_rank_nop3;

vox_rank_nop4 = 1:num_vox;
vox_rank_nop4(idxno4) = vox_rank_nop4;

vox_rank_sp1 = 1:num_vox;
vox_rank_sp1(idxs1) = vox_rank_sp1;

vox_rank_sp2 = 1:num_vox;
vox_rank_sp2(idxs2) = vox_rank_sp2;

vox_rank_sp3 = 1:num_vox;
vox_rank_sp3(idxs3) = vox_rank_sp3;

vox_rank_sp4 = 1:num_vox;
vox_rank_sp4(idxs4) = vox_rank_sp4;


%Average across pairs
o1 = (op1_1 + op2_1)/2;
o2 = (op1_2 + op2_2)/2;

no1 = (nop1_1 + nop2_1)/2;
no2 = (nop1_2 + nop2_2)/2;

s1 = (sp1_1 + sp2_1 + sp3_1 + sp4_1)/4;
s2 = (sp1_2 + sp2_2 + sp3_2 + sp4_2)/4;

one1 = ones(1,num_vox);
two2 = one1*2;

%Average datamat 
dataMat(1,:) = [s1 s2 o1 o2 no1 no2]; %corrs
dataMat(2,:) = ceil([1:length(dataMat(1,:))]./(length(dataMat(1,:))/3)); %same 1 overlap 2 nonoverlap 3
dataMat(3,:) = [one1 two2 one1 two2 one1 two2];%half

%Overlap datamat by pair
oMat(1,:) = [op1_1 op2_1 op1_2 op2_2];
oMat(2,:) = repmat(1:num_vox,1,4); %vox number
oMat(3,:) = [vox_rank_op1 vox_rank_op2 vox_rank_op1 vox_rank_op2]; %ranking based on half 1 corrs
oMat(4,:) = [one1 one1 two2 two2]; %half

if mod(S.sub,2) == 1
    oMat(5,:) = [one1+2 two2+2 one1+2 two2+2]; %pair 
else
    oMat(5,:) = [one1 two2 one1 two2]; %pair 
end

%Non-Overlap datamat by pair
noMat(1,:) = [nop1_1 nop2_1 nop3_1 nop4_1 nop1_2 nop2_2 nop3_2 nop4_2];
noMat(2,:) = repmat(1:num_vox,1,8); %vox number
noMat(3,:) = [vox_rank_nop1 vox_rank_nop2 vox_rank_nop3 vox_rank_nop4 vox_rank_nop1 vox_rank_nop2 vox_rank_nop3 vox_rank_nop4]; %ranking based on half 1 corrs
noMat(4,:) = [one1 one1 one1 one1 two2 two2 two2 two2]; %half
if mod(S.sub,2) == 1
    noMat(5,:) = [two2+3 two2+4 two2+5 two2+6 two2+3 two2+4 two2+5 two2+6]; %pair 
else
    noMat(5,:) = [one1 two2 one1+2 two2+2 one1 two2 one1+2 two2+2]; %pair 
end

%Same-Route datamat by pair
sMat(1,:) = [sp1_1 sp2_1 sp3_1 sp4_1 sp1_2 sp2_2 sp3_2 sp4_2];
sMat(2,:) = repmat(1:num_vox,1,8); %vox number
sMat(3,:) = [vox_rank_sp1 vox_rank_sp2 vox_rank_sp3 vox_rank_sp4 vox_rank_sp1 vox_rank_sp2 vox_rank_sp3 vox_rank_sp4]; %ranking based on half 1 corrs
sMat(4,:) = [one1 one1 one1 one1 two2 two2 two2 two2]; %half
if mod(S.sub,2) == 1
    sMat(5,:) = [two2+3 two2+4 two2+5 two2+6 two2+3 two2+4 two2+5 two2+6]; %pair 
else
    sMat(5,:) = [one1 two2 one1+2 two2+2 one1 two2 one1+2 two2+2]; %pair 
end

%combine all (by-pair) mats
combMat = [oMat noMat sMat];
combMat(6,:)= [ones(1,size(oMat,2)) (ones(1,size(noMat,2))+1) (ones(1,size(sMat,2))+2)];


%same route by moderately active voxels in the overlapping routes
srxo(1,:) = [vox_rank_op1 vox_rank_op2 vox_rank_op1 vox_rank_op2]; %overlapping vox ranking
srxo(2,:) = [(sp1_1+sp2_1)/2 (sp3_1+sp4_1)/2 (sp1_2+sp2_2)/2 (sp3_2+sp4_2)/2]; % same route sim averaged across same routes within the overlapping pair at each voxel
srxo(3,:) = [one1 one1 two2 two2]; %half
if mod(S.sub,2) == 1
    srxo(4,:) = [one1+2 two2+2 one1+2 two2+2]; %overlap pair 
else
    srxo(4,:) = [one1 two2 one1 two2]; %overlap pair 
end


%Spearman rank correlations based on first half timecourse similarity
%rankings

%same route
[sp_sr(1),~] = corr(vox_rank_sp1',vox_rank_sp2','type','Spearman');
[sp_sr(2),~] = corr(vox_rank_sp1',vox_rank_sp3','type','Spearman');
[sp_sr(3),~] = corr(vox_rank_sp1',vox_rank_sp4','type','Spearman');
[sp_sr(4),~] = corr(vox_rank_sp2',vox_rank_sp3','type','Spearman');
[sp_sr(5),~] = corr(vox_rank_sp2',vox_rank_sp4','type','Spearman');
[sp_sr(6),~] = corr(vox_rank_sp3',vox_rank_sp4','type','Spearman');

%overlapping pairs
[op_sr,~] = corr(vox_rank_op1',vox_rank_op2','type','Spearman');

%non overlapping pairs
[no_sr(1),~] = corr(vox_rank_nop1',vox_rank_nop2','type','Spearman');
[no_sr(2),~] = corr(vox_rank_nop1',vox_rank_nop3','type','Spearman');
[no_sr(3),~] = corr(vox_rank_nop1',vox_rank_nop4','type','Spearman');
[no_sr(4),~] = corr(vox_rank_nop2',vox_rank_nop3','type','Spearman');
[no_sr(5),~] = corr(vox_rank_nop2',vox_rank_nop4','type','Spearman');
[no_sr(6),~] = corr(vox_rank_nop3',vox_rank_nop4','type','Spearman');

%Fisher z
sp_sr = fisherz(sp_sr);
op_sr = fisherz(op_sr);
no_sr = fisherz(no_sr);

%Calcuate % of voxels that are binned in the same bin across route
%comparison
sp1_bin = ceil(vox_rank_sp1/100);
sp2_bin = ceil(vox_rank_sp2/100);
sp3_bin = ceil(vox_rank_sp3/100);
sp4_bin = ceil(vox_rank_sp4/100);

op1_bin = ceil(vox_rank_op1/100);
op2_bin = ceil(vox_rank_op2/100);

no1_bin = ceil(vox_rank_nop1/100);
no2_bin = ceil(vox_rank_nop2/100);
no3_bin = ceil(vox_rank_nop3/100);
no4_bin = ceil(vox_rank_nop4/100);

sp_percov(1) = sum(sp1_bin == sp2_bin)/300;
sp_percov(2) = sum(sp1_bin == sp3_bin)/300;
sp_percov(3) = sum(sp1_bin == sp4_bin)/300;
sp_percov(4) = sum(sp2_bin == sp3_bin)/300;
sp_percov(5) = sum(sp2_bin == sp4_bin)/300;
sp_percov(6) = sum(sp3_bin == sp4_bin)/300;

op_percov = sum(op1_bin == op2_bin)/300;

no_percov(1) = sum(no1_bin == no2_bin)/300;
no_percov(2) = sum(no1_bin == no3_bin)/300;
no_percov(3) = sum(no1_bin == no4_bin)/300;
no_percov(4) = sum(no2_bin == no3_bin)/300;
no_percov(5) = sum(no2_bin == no4_bin)/300;
no_percov(6) = sum(no3_bin == no4_bin)/300;

srMat(1,:) = [mean(sp_sr) op_sr mean(no_sr)]; %spearman rank correlation
srMat(2,:) = [mean(sp_percov) op_percov mean(no_percov)]; %percent of voxels in same bin
srMat(3,:) = [1 2 3];


end


   
