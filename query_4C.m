function [ bad_set ] = query_4C( LDPCM, row )
%QUERY_COLUMN Summary of this function goes here
%   LDPCM is the partially completed LDPC matrix
    if isempty(LDPCM)
        bad_set = [];
        return;
    end

    pot_bad_cols = [];
    bad_set = [];
    for i = 1:size(LDPCM,2)
        if LDPCM(row, i) == 1 %&& sum(LDPCM(:,i)) == 2
            pot_bad_cols = [ pot_bad_cols , i];
        end
    end
    
    for j = 1:size(LDPCM,1)
        if sum(LDPCM(j, pot_bad_cols)) ~= 0
            bad_set = [ bad_set , j];
        end
    end
    bad_set = [bad_set , row];
end

