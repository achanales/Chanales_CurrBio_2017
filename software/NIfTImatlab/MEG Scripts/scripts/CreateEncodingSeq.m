%CreateEncodingSeq.m
%
%This script takes the itemList and colorList matrices and creates Encoding
%sequences for each subject for the MEGbound study
%
%AH 6.5.2012

cd /Volumes/davachilab/MEGbound/Encoding/

load itemColorList
load /Volumes/davachilab/MEGbound/scripts/colorsamples

colorsamples = round(colorsamples.*255);

for isamples1 = 1:12
    
    for isamples2 = 1:576
        
        colorsamplesMtx(:,isamples2,isamples1)= colorsamples(colorList(isamples2,isamples1),:);
        
    end
    
end

for ilist = 1:12
    
    encodingSeq = {};
    
    for itmp = 1:576
        
    col1{itmp,1} = [num2str(itemList(itmp,ilist)) '.bmp'];
    
    end;
    
    
    col2 = repmat({'B' 'NB' 'NB' 'NB' 'NB' 'PB'}',96,1);
    
    col3 = repmat([1:6]',96,1);
    
    col4 = colorList(:,ilist);
    
    col5 = colorsamplesMtx(1,:,ilist)';
    
    col6 = colorsamplesMtx(2,:,ilist)';
    
    col7 = colorsamplesMtx(3,:,ilist)';
    
encodingSeq = [col1 col2 num2cell(col3) num2cell(col4) num2cell(col5) num2cell(col6) num2cell(col7)];

save(['encodingSeq',num2str(ilist)],'encodingSeq')
    
end
    
    